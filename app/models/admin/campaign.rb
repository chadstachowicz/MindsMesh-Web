
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter
  has_and_belongs_to_many :entity
  has_and_belongs_to_many :user
  accepts_nested_attributes_for :entity
  accepts_nested_attributes_for :user

  attr_accessible :kind, :user_id, :historic, :newsletter_id, :entity_id 
  ROLES = {
            'admin'     =>  30,
            'student'   => 10,
            'moderator' => 1
          }

  def self.send_mails_and_save(data)
    nl   = Admin::Newsletter.find(data[:newsletter_id])
    kind = data[:kind]
    emails = 0
    data[:entity_ids].each do |k,v|
        logger.debug "#llllllllllllllllllentity -> #{k} -> #{v} \n \n"
        v[:user_ids].each do |ok, ov|
            logger.debug "#lllllllll->llllllllllllll #{ok} -> #{ov} \n \n"
            role_integer = ROLES[ok]
            hashu = {entity_id:k, role_i:role_integer}  
            logger.debug "#ll-> hashu -> #{hashu}  \n \n"
            q = "SELECT u.id AS id, u.name AS name, u.email AS email, eu.entity_id AS entity_id FROM entity_users AS eu, users AS u WHERE eu.user_id=u.id AND eu.entity_id=#{k} AND u.role_i=#{role_integer}"
            logger.debug "#q:-> #{q} "
            users = User.find_by_sql(q)
            users.each do |u|
                logger.debug "#ll-> user  -> #{u}  \n \n"
                campaing = { kind:kind, historic:false, user_id:u.id, newsletter_id:nl.id, entity_id:u.entity_id}
                transaction do
                    admin_campaign = new(campaing)

                    if admin_campaign.save
                        # logger.debug "eur saved!!"
                        MyMail.send_newsletter(u,nl).deliver
                        emails = emails+1
                    end
                end
            end
        end
    end
    return emails
  end

end
