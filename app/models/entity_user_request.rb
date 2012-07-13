class EntityUserRequest < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user

  attr_accessible :email

  validates_presence_of :entity
  validates_presence_of :user
  validates_presence_of :email
  validates_uniqueness_of :email, scope: :entity_id
  validates_uniqueness_of :user_id, scope: :entity_id

  validates_email_format_of :email
  validate do
    errors[:email] << "'#{email}' is not a valid @uncc.edu email address" unless errors[:email].any? || email.downcase.include?("@uncc.edu")
  end

  def to_param
    confirmation_token
  end

  def generate_and_mail_new_token
    transaction do
      self.last_email_sent_at = Time.now
      self.confirmation_token = Digest::MD5.hexdigest(Time.now.to_s)
      
      if save && Rails.env.development?
        confirm
      else
        MyMail.confirmation(self).deliver
      end
    end
  end

  before_save do
    self.email = email.downcase
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirm
    return false if confirmed?
    transaction do
      entity.user_join!(user)
      update_attribute(:confirmed_at, Time.now)
      user.id
    end
  end
end
