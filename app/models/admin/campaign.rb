
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter
  belongs_to :entity
  has_many :campaigns_users, :class_name => 'Admin::CampaignsUsers',  foreign_key: "admin_campaign_id", :dependent => :delete_all
  has_many :campaign_attr, :class_name => 'Admin::CampaignAttr',  foreign_key: "admin_campaign_id", :dependent => :delete_all
  
  accepts_nested_attributes_for :entity
  accepts_nested_attributes_for :campaign_attr, :allow_destroy => :true
  attr_accessible :kind, :historic, :newsletter_id, :delivered, :scheduled, :futuretime 
  attr_accessor :send_reminders

  self.skip_time_zone_conversion_for_attributes = [:futuretime] 

  # class states
  @kind  = 0
  @hours = 0
 
  # Only create the campaign
  def self.create_campaign(data)
    schedul        = data[:scheduled]
    future         = schedul == '2' ? data[:futuretime] : Time.now.strftime("%Y-%m-%d %H:%M:%S")
    kind           = data[:kind]
    delivered      = data[:scheduled] == "1" ? true : false
   
    campaign       = { kind:kind, scheduled:schedul, futuretime:future, delivered:delivered, newsletter_id:data[:newsletter_id] }
    
    admin_campaign = new(campaign)

    if data.has_key?(:entity_ids)
        data[:entity_ids].each do |k,v|    # k = entity_id , v = values_selected
            admin_campaign.campaign_attr.build({entity_id:k, key:'entity'})
            v[:user_ids].each do |ok, ov|
                admin_campaign.campaign_attr.build({entity_id:k,key:kind,value:ov})
            end
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
    ac_id          = admin_campaign.id
    nl             = Admin::Newsletter.find(admin_campaign.newsletter_id)
    emails         = 0
    usersfound     = 0
    
    @kind = admin_campaign.kind
    if @kind == 'everybody'
        users = get_emails(0, 0) # all users
        users.each do |u|
            usersfound = usersfound+1
            logger.debug "User:  -> #{u.inspect}  \n\n" if Rails.env.development?
            fieldsacu = {admin_campaign_id:ac_id, delivered:true, user_id:u.id}
            acu = Admin::CampaignsUsers.new fieldsacu
                if acu.save
                    #MyMail.send_newsletter(u,nl,emails).deliver
                    emails = emails+1
                end
        end
    else
        entities  = Admin::CampaignAttr.where(:admin_campaign_id=>ac_id, :key=>'entity')
        entities.each do |entity|
            types = Admin::CampaignAttr.where(:admin_campaign_id=>ac_id, :entity_id => entity.entity_id, :key=>@kind)
            types.each do |t|
                users = get_emails(t.value, entity.entity_id)
                users.each do |u|
                    usersfound = usersfound+1
                    logger.debug "User:  -> #{u.inspect}  \n\n" if Rails.env.development?
                    fieldsacu = {admin_campaign_id:ac_id, delivered:true, user_id:u.id, entity_id:entity.entity_id}
                    acu  = Admin::CampaignsUsers.new fieldsacu
                    if acu.save
                        # MyMail.send_newsletter(u,nl,emails).deliver
                       #emails = emails+1
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
    scheduled
    after_registration
  end

  def self.scheduled
    q="SELECT id FROM admin_campaigns WHERE scheduled = 2 AND date(now()) = date(futuretime) AND hour(now()) = hour(futuretime)" # get by date and hour

    campaigns = Admin::Campaign.find_by_sql(q)

    campaigns.each do |c|
       data = send_mails_and_save(c.id)
    end
  end

  # Send n hours after registration
  def self.after_registration(hours=24)
    @hours = hours
    campaigns = Admin::Campaign.where(:scheduled => 3)  # 3 = after 24 hours confirmed_at
    campaigns.each do |c|
       data = send_mails_and_save(c.id)   
    end
  end

  # Last 100 sent
  def self.get_last_sent
    q  = "SELECT u.name AS name, u.email AS email, nl.title AS campaign, acu.created_at AS sent, acu.id AS id, ac.kind AS kind FROM users AS u, "
    q += " admin_newsletters AS nl, admin_campaigns_users AS acu, admin_campaigns AS ac" 
    q += " WHERE nl.id = ac.newsletter_id AND acu.admin_campaign_id = ac.id AND u.id=acu.user_id ORDER BY acu.id DESC LIMIT 100"
    users = User.find_by_sql q
  end
  private
  
  # after choose between the options, get the users emails to send
  def self.get_emails(value, entity_id)
    extract = "HOUR(eur.confirmed_at) = #{@hours}"
    case @kind
        when 'users'
            q  = "SELECT u.id AS id, u.name AS name, u.email AS email FROM users AS u "
            q += " INNER JOIN entity_users AS eu ON eu.user_id=u.id AND eu.entity_id=#{entity_id} "
            q += " INNER JOIN entity_user_requests AS eur ON eur.user_id=u.id AND eur.entity_id=eu.entity_id AND u.role_i = #{value}"
            q += " AND #{extract}" if @hours == 24
            q += " GROUP by u.id"
        when 'groups'
            q  = "SELECT u.id AS id, u.name AS name, u.email AS email FROM group_users AS gu" 
            q += " INNER JOIN groups AS g ON g.id=gu.group_id"
            q += " INNER JOIN entity_user_requests AS eur ON eur.user_id=gu.user_id AND #{extract}"  if @hours == 24
            q += " INNER JOIN users AS u ON gu.user_id=u.id AND g.entity_id=#{entity_id} AND g.id = #{value} GROUP BY u.id" 
        when 'topics'
            q  = "SELECT u.id AS id, u.name AS name, u.email AS email FROM topic_users AS tu"
            q += " INNER JOIN users AS u ON tu.user_id=u.id"
            q += " INNER JOIN entity_user_requests AS eur ON eur.user_id=u.id AND #{extract}"  if @hours == 24
            q += " INNER JOIN topics AS t ON t.id = tu.topic_id AND t.entity_id=#{entity_id} AND tu.topic_id=#{value} GROUP BY u.id"
        when 'everybody'
            q  = "SELECT u.id AS id, u.name AS name, u.email AS email FROM users AS u" 
            q += " INNER JOIN entity_user_requests AS eur ON eur.user_id=u.id"
            q += " AND #{extract}" if @hours == 24
            q += " GROUP BY u.id"
    end 
    logger.debug "Query:  -> #{q}  \n\n" if Rails.env.development?
    #users = User.connection.select_all(q)
    users = User.find_by_sql q
  end
end
