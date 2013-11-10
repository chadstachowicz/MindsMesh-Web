
# MindsMesh (c) 2013

class EntityUserRequest < ActiveRecord::Base

  belongs_to :entity
  belongs_to :user

  attr_accessible :email

  validates_presence_of :entity
  validates_presence_of :user
  validates_presence_of :email

  validates_email_format_of :email

  def to_param
    confirmation_token
  end

  def generate_and_mail_new_token
    transaction do
        self.last_email_sent_at = Time.now
        self.confirmation_token = Digest::MD5.hexdigest(Time.now.to_s)
        
        #if save && Rails.env.development?
        #    confirm
        # else
        #    MyMail.confirmation(self).deliver
        # end
        if save
           logger.debug "eur saved!!"
           MyMail.confirmation(self)
           
        end
    end
  end

  before_save do
    self.email = email.downcase
  end

  def confirmed?
    confirmed_at.present?  # email is already confirmed
  end

  def confirm
    return false if confirmed?
    transaction do
      #deprecated
      #entity_user.joins_self_joinings_topics
      update_attribute(:confirmed_at, Time.now)
      entity_user = entity.user_join!(user)
    end
  end
end
