
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter
  belongs_to :entity
  has_many :campaigns_users, :class_name => 'Admin::CampaignsUsers',  foreign_key: "admin_campaign_id", :dependent => :delete_all
  #has_many :user, :through => :campaign_user
  serialize :entity, Hash

  #has_and_belongs_to_many :entity
  #has_and_belongs_to_many :user
  accepts_nested_attributes_for :entity
  #accepts_nested_attributes_for :user

  attr_accessible :kind, :historic, :newsletter_id, :entity_id, :delivered, :scheduled, :futuretime 

  attr_accessor :send_reminders

  ROLES = {
            'master'    => 30,
            'admin'     => 20,
            'student'   => 10,
            'moderator' => 1
          }

  # send to all users
  def self.everybody(data)
    sch_options   = {now:1, future:2, tfh:3, week:4}
    nl            = Admin::Newsletter.find(data[:newsletter_id])
    schedul       = sch_options[data[:scheduled].to_s.to_sym]
    future        = data[:futuretime]
    delivered     = data[:scheduled] == "now" ? true : false
    kind          = data[:kind]
    emails        = 0
    usersfound    = 0

    campaing      = { kind:kind, scheduled:schedul, futuretime:future, historic:false, newsletter_id:nl.id }

    admin_campaign = create(campaing)
    
    users = User.find(:all,:select => "id, name, email")

    users.each do |u|
        # logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development? 
        usersfound    = usersfound+1
        campaing_user = { admin_campaign_id:admin_campaign.id, delivered:delivered, user_id:u.id }
        transaction do
            admin_campaign = Admin::CampaignsUsers.new(campaing_user)
            if admin_campaign.save && delivered 
                # logger.debug "Data saved!!" if Rails.env.development?
                MyMail.send_newsletter(u,nl,emails).deliver
                emails = emails+1
            end
        end
    end
    data = {emails:emails, scheduled:schedul, usersfound:usersfound, nl_id:nl.id }
  end
  
  # send and save in campaigns
  def self.send_mails_and_save(data)
    sch_options   = {now:1, future:2, tfh:3, week:4}
    nl            = Admin::Newsletter.find(data[:newsletter_id])
    schedul       = sch_options[data[:scheduled].to_s.to_sym]
    future        = data[:futuretime]
    delivered     = data[:scheduled] == "now" ? true : false
    kind          = data[:kind]
    emails        = 0
    usersfound    = 0

    campaing      = { kind:kind, scheduled:schedul, futuretime:future, historic:false, newsletter_id:nl.id }
    
    admin_campaign = create(campaing)
    
    data[:entity_ids].each do |k,v|    # k = entity_id
        users = get_emails(v, kind, k)
        users.each do |u|
            usersfound = usersfound+1
            # logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development? 
            campaing_user = { admin_campaign_id:admin_campaign.id, historic:false, user_id:u.id, entity_id:u.entity_id }
            transaction do
                admin_campaign = new(campaing)
                if admin_campaign.save && delivered
                    # logger.debug "eur saved!!" if Rails.env.development?
                    MyMail.send_newsletter(u,nl,emails).deliver
                    emails = emails+1
                end
            end
        end
    end
    data = {emails:emails, scheduled:schedul, usersfound:usersfound, nl_id:nl.id}
  end
  
  def self.send_reminders
    MyMail.mail_test().deliver
  end

  def self.cronjobs
    twenty_hours
    scheduled
  end

  private

=begin def self.twenty_hours
    return false
    campaigns = Admin::Newsletter.where(:scheduled=>true);
    campaigns = find(); 
    uer   = UserEntityRequest.where(confirmed_at 24)
    uer.each do |u|
        campaing = { kind:kind, historic:false, user_id:u.id, newsletter_id:nl.id, entity_id:u.entity_id}
            transaction do
                admin_campaign = new(campaing)
                if admin_campaign.save
                    # logger.debug "eur saved!!" if Rails.env.development?
                    MyMail.send_newsletter(u,nl,emails).deliver
                    emails = emails+1
                end
            end
    end
  end

  def self.scheduled
    return false
    campaigns = Admin::Campaign.where(:scheduled=>true, :futuretime => );
    uer.each do |u|
        campaing = { kind:kind, historic:false, user_id:u.id, newsletter_id:nl.id, entity_id:u.entity_id}
            transaction do
                admin_campaign = new(campaing)
                if MyMail.send_newsletter(u,nl,emails).deliver
                    # logger.debug "eur saved!!" if Rails.env.development?
                    delivered_campaign = Admin::Campaign.find()
                    delivered_.update_column(:delivered, true)
                end
            end
    end
  end
=end
  # after choose between the options, get the users emails to send
  def self.get_emails(values, kind, k)
    case kind
        when 'users'
            return get_users(values, k)
        when 'groups'
            return get_groups(values, k)
        when 'topics'
            return get_topics(values, k)
     end 
  end

  def self.get_users(values, k)
    values[:user_ids].each do |ok, ov|
        #logger.debug "#lllllllll->llllllllllllll #{ok} -> #{ov} \n \n"  if Rails.env.development?
        role_integer = ROLES[ok] 
        # logger.debug "#ll-> hashu -> #{hashu}  \n \n"
        q = "SELECT u.id AS id, u.name AS name, u.email AS email, eu.entity_id AS entity_id FROM entity_users AS eu, users AS u WHERE eu.user_id=u.id AND eu.entity_id=#{k} AND u.role_i=#{role_integer}"
        # logger.debug "#q:-> #{q} "
        users = User.find_by_sql(q)
        return users
    end    
  end

  def self.get_groups(values, k)
    values[:user_ids].each do |ok, ov|
        # logger.debug "#llll-> #{ok} -> #{ov} \n \n"  if Rails.env.development?   # false user_ids
        
        q = "SELECT u.id AS id, u.name AS name, u.email AS email, g.entity_id AS entity_id FROM group_users AS gu, groups AS g, users AS u WHERE gu.group_id=g.id AND gu.user_id=u.id AND g.entity_id=#{k} AND g.id=#{ov}"
        logger.debug "#q:-> #{q} " if Rails.env.development?
        users = User.find_by_sql(q)
        return users
    end    
  end


  def self.get_topics(values, k)
    values[:user_ids].each do |ok, ov|
        logger.debug "# at get_topics ->  #{ok} -> #{ov} \n \n"  if Rails.env.development?
        
        q = "SELECT u.id AS id, u.name AS name, u.email AS email, t.entity_id AS entity_id FROM topic_users AS tu, topics AS t,users AS u WHERE t.user_id=u.id AND tu.topic_id=t.id AND t.entity_id=#{k} AND tu.topic_id=#{ov}"
        # logger.debug "#q:-> #{q} " if Rails.env.development?
        users = User.find_by_sql(q)
        return users
    end    
  end

end
