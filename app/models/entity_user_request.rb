class EntityUserRequest < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user

  attr_accessible :email

  validates_presence_of :entity
  validates_presence_of :user
  validates_presence_of :email
  validates_uniqueness_of :email, scope: :entity_id

  validates_email_format_of :email
  validate do
    errors[:email] << "'#{email}' is not a valid @uncc.edu email address" unless errors[:email].any? || email.include?("@uncc.edu")
  end

  def to_param
    confirmation_token
  end

  before_save do
    self.email = email.downcase
    self.confirmation_token = Digest::MD5.hexdigest(Time.now.to_s)
    #TODO: send email
  end

  def confirm
    transaction do
      entity.entity_users.create do |su|
        su.user_id = user.id#force select, so it validates that user exists
        #su.b_student = true
      end
      user.roles += ['user']
      user.save
      destroy
      user.id
    end
  end
end