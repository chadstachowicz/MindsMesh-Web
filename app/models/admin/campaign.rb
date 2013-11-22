
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter
  has_and_belongs_to_many :entity
  has_and_belongs_to_many :user
  accepts_nested_attributes_for :entity
  accepts_nested_attributes_for :user

  attr_accessible :kind, :user_id, :historic, :newsletter_id, :entity_id 
  ROLES = {
            'admin'     => 30,
            'student'   => 10,
            'moderator' => 1
          }
    
  def self.send_mails_and_save(data)
    nl   = Admin::Newsletter.find(data[:newsletter_id])
    kind = data[:kind]
    emails = 0
    data[:entity_ids].each do |k,v|    # k = entity_id
        users = get_emails(v, kind, k)
        users.each do |u|
            logger.debug "#ll-> user  -> #{u}  \n \n" if Rails.env.development? 
            campaing = { kind:kind, historic:false, user_id:u.id, newsletter_id:nl.id, entity_id:u.entity_id}
            transaction do
                admin_campaign = new(campaing)
                if admin_campaign.save
                    # logger.debug "eur saved!!" if Rails.env.development?
                    MyMail.send_newsletter(u,nl).deliver
                    emails = emails+1
                end
            end
        end
    end
    return emails
  end
  
  def send_remainders
    MyMail.mail_test().deliver
  end

  private

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
        logger.debug "#lllllllll->llllllllllllll #{ok} -> #{ov} \n \n"  if Rails.env.development?   # false user_ids
        
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
