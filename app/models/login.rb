class Login < ActiveRecord::Base
  belongs_to :user
  attr_accessible :auth_s, :provider, :uid
  validates_presence_of :provider
  validates_presence_of :uid
  validates_presence_of :auth_s

  def self.auth!(auth)
    raise "invalid facebook login" if auth.nil?
    transaction do
      login = Login.where(provider: auth["provider"], uid: auth["uid"].to_s).first_or_initialize

      login.auth_s = auth.to_json
      #login.permissions = "email"
      
      login.build_user if login.new_record?

      login.user.name          = auth["info"]["name"]
      login.user.gender        = auth["info"]["gender"]
      login.user.fb_id         = login.uid
      login.user.fb_token      = auth['credentials']['token']
      login.user.fb_expires_at = Time.at(auth['credentials']['expires_at'])
      login.save!
      login.user.save!
      login
    end
  end

  def auth
    return :auth_nil if auth_s.nil?
    JSON.load(auth_s)
  end

end
