class SchoolUserRequest < ActiveRecord::Base
  belongs_to :school
  belongs_to :user

  attr_accessible :email

  validates_presence_of :school
  validates_presence_of :user
  validates_presence_of :email
  validates_uniqueness_of :email, scope: :school_id

  validates_email_format_of :email
  validate do
    errors[:email] << "'#{email}' is not a valid @uncc.edu email address" unless errors[:email].any? || email.include?("@uncc.edu")
  end

  before_save do
    self.email = email.downcase
    self.confirmation_token = Digest::MD5.hexdigest(Time.now.to_s)
    #TODO: send email
  end
end
