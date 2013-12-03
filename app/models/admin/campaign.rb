
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter
  belongs_to :entity
  has_many :campaigns_users, :class_name => 'Admin::CampaignsUsers',  foreign_key: "admin_campaign_id", :dependent => :delete_all
  has_many :campaign_attr, :class_name => 'Admin::CampaignAttr',  foreign_key: "admin_campaign_id", :dependent => :delete_all
  
  serialize :entity, Hash

  #has_and_belongs_to_many :entity
  #has_and_belongs_to_many :user
  accepts_nested_attributes_for :entity
  accepts_nested_attributes_for :campaign_attr, :allow_destroy => :true
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
    nl            = Admin::Newsletter.find(data[:newsletter_id])
    schedul       = data[:scheduled]
    future        = schedul == '2' ? data[:futuretime] : Time.now.strftime("%Y-%m-%d %H:%M:%S")
    delivered     = data[:scheduled] == "1" ? true : false
    kind          = 'everybody'

    campaign      = { kind:kind, scheduled:schedul, futuretime:future, delivered:delivered, newsletter_id:nl.id }

    admin_campaign = create(campaign)
    
    if schedul == '1'
        data = send_mails_and_save(admin_campaign.id)
    end
  end
  
  # Only create the campaign
  def self.create_campaign(data)
    schedul       = data[:scheduled]
    future        = schedul == '2' ? data[:futuretime] : Time.now.strftime("%Y-%m-%d %H:%M:%S")
    kind          = data[:kind]
    delivered     = data[:scheduled] == "1" ? true : false
   
    campaign      = { kind:kind, scheduled:schedul, futuretime:future, delivered:delivered, newsletter_id:data[:newsletter_id] }
    
    admin_campaign = new(campaign)
    entities = Hash.new
    data[:entity_ids].each do |k,v|    # k = entity_id , v = values
        # logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development?
        admin_campaign.campaign_attr.build({key:'entity',value:k})
        #entities['entity'] = k
        v[:user_ids].each do |ok, ov|
           admin_campaign.campaign_attr.build({key:kind,value:ov})
        end
    end
    
    admin_campaign.save
    
    if schedul == '1'
        data = send_mails_and_save(admin_campaign.id)
    end
    
    return data
  end

  # Send and save in campaign_users
  def self.send_mails_and_save(campaign_id)

    admin_campaign = find(campaign_id)
    nl             = Admin::Newsletter.find(admin_campaign.newsletter_id)
    emails         = 0
    usersfound     = 0
    

    if admin_campaign.kind == 'everybody'
        users = User.find(:all,:select => "id, name, email")
        users.each do |u|
            # logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development? 
            usersfound    = usersfound+1
            campaing_user = { admin_campaign_id:admin_campaign.id, delivered:true, user_id:u.id }
            transaction do
                admin_campaign = Admin::CampaignsUsers.new(campaing_user)
                if admin_campaign.save 
                    # logger.debug "Data saved!!" if Rails.env.development?
                    MyMail.send_newsletter(u,nl,emails).deliver
                    emails = emails+1
                end
            end
        end
    else
        entities       = Admin::CampaignAttr.where(:admin_campaign_id=>campaign_id, :key=>'entity')
    
        entities.each do |entity|    # k = entity_id 

            type = Admin::CampaignAttr.where(:admin_campaign_id=>campaign_id, :key=>admin_campaign.kind)
            type.each do |t|
                logger.debug "#### Entity-> values  -> #{t.inspect}  \n \n" if Rails.env.development?

                users = get_emails(t.value, admin_campaign.kind, entity.value)
                users.each do |u|
                    usersfound = usersfound+1
                    # logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development?
                    transaction do
                        camp_user = {admin_campaign_id:admin_campaign.id, delivered:true, user_id:u.id, entity_id:entity.key}
                        campaigns_users = Admin::CampaignsUsers.new(camp_user)
                        if campaigns_users.save
                            MyMail.send_newsletter(u,nl,emails).deliver
                            emails = emails+1
                        end
                    end
                end
            end
        end
    end
    data = {emails:emails, usersfound:usersfound, nl_id:nl.id}
  end
  
  def self.send_reminders
    MyMail.mail_test().deliver
  end

  def self.cronjobs
    twentyfour_hours
    scheduled
  end

  def self.scheduled

    q='SELECT id FROM admin_campaigns WHERE scheduled = 2 AND (EXTRACT(EPOCH FROM current_timestamp - "futuretime")/3600)::Integer = 0'

    campaigns = Admin::Campaign.find_by_sql(q);

    campaigns.each do |c|
       data = send_mails_and_save(admin_campaign.id)
    end
  end

  # Send the 24h campaign
  def self.twentyfour_hours
    campaigns = Admin::Campaign.where(:scheduled => 2)
    tfourhs='(EXTRACT(EPOCH FROM current_timestamp - "eur"."confirmed_at")/3600)::Integer = 24'
    campaigns.each do |c|
        entities       = Admin::CampaignAttr.where(:admin_campaign_id=>c.id, :key=>'entity')
        entities.each do |ent|
            types = Admin::CampaignAttr.where(:admin_campaign_id=>c.id, :key=>c.kind)
            types.each do |t|
                case c.kind
                    when 'users'
                        q  = "SELECT u.id AS id, u.name AS name, u.email AS email, eu.entity_id AS entity_id FROM entity_users AS eu, users AS u, entity_user_requests AS eur "
                        q += "WHERE eu.user_id=u.id AND eur.user_id=u.id AND eu.entity_id=#{ent.value} AND u.role_i=#{t.value} AND #{tfourhs}"
                        # logger.debug "#q:-> #{q} "
                    when 'groups'
                        q = "SELECT u.id AS id, u.name AS name, u.email AS email, g.entity_id AS entity_id FROM group_users AS gu, groups AS g, users AS u WHERE gu.group_id=g.id AND gu.user_id=u.id AND g.entity_id=#{entity_id} AND g.id=#{value} AND #{tfourhs}"
                    when 'topics'
                        q = "SELECT u.id AS id, u.name AS name, u.email AS email, t.entity_id AS entity_id FROM topic_users AS tu, topics AS t,users AS u WHERE t.user_id=u.id AND tu.topic_id=t.id AND t.entity_id=#{entity_id} AND tu.topic_id=#{value} AND #{tfourhs}"
                end 
                users = User.find_by_sql(q)

                if !users.empty?
                    nl   = Admin::Newsletter.find(c.newsletter_id)
                else
                    break
                end
                users.each do |u|
                    transaction do
                        camp_user = {admin_campaign_id:c.id, delivered:true, user_id:u.id, entity_id:ent.value}
                        campaigns_users = Admin::CampaignsUsers.new(camp_user)
                        if campaigns_users.save
                            # logger.debug "eur saved!!" if Rails.env.development?
                            MyMail.send_newsletter(u,nl,emails).deliver
                            emails = emails+1
                        end
                    end
                end
            end
        end
    end
  end


  private
  
  # after choose between the options, get the users emails to send
  def self.get_emails(value, kind, entity_id)
    case kind
        when 'users'
            return get_users(value, entity_id)
        when 'groups'
            return get_groups(value, entity_id)
        when 'topics'
            return get_topics(value, entity_id)
     end 
  end
  
  def self.get_users(value, entity_id)
    q = "SELECT u.id AS id, u.name AS name, u.email AS email, eu.entity_id AS entity_id FROM entity_users AS eu, users AS u WHERE eu.user_id=u.id AND eu.entity_id=#{entity_id} AND u.role_i=#{value}"
    # logger.debug "#q:-> #{q} "
    users = User.find_by_sql(q)
  end

  def self.get_groups(value, entity_id)
    q = "SELECT u.id AS id, u.name AS name, u.email AS email, g.entity_id AS entity_id FROM group_users AS gu, groups AS g, users AS u WHERE gu.group_id=g.id AND gu.user_id=u.id AND g.entity_id=#{entity_id} AND g.id=#{value}"
    #logger.debug "#q:-> #{q} " if Rails.env.development?
    users = User.find_by_sql(q)
  end


  def self.get_topics(value, entity_id) 
    q = "SELECT u.id AS id, u.name AS name, u.email AS email, t.entity_id AS entity_id FROM topic_users AS tu, topics AS t,users AS u WHERE t.user_id=u.id AND tu.topic_id=t.id AND t.entity_id=#{entity_id} AND tu.topic_id=#{value}"
    # logger.debug "#q:-> #{q} " if Rails.env.development?
    users = User.find_by_sql(q)
  end

end
