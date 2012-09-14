require 'stalker'
class Login < ActiveRecord::Base
  belongs_to :user
  attr_accessible :auth_s, :provider, :uid
  validates_presence_of :provider
  validates_presence_of :uid
  #validates_presence_of :auth_s

  def self.auth!(auth)
    raise "invalid facebook login" if auth.nil?
    transaction do
      login = Login.where(provider: auth["provider"], uid: auth["uid"].to_s).first_or_initialize

      login.auth_s = auth.to_json
      #login.permissions = "email"
      login.update_with_facebook_data!(
        auth["info"]["name"],
        auth["info"]["gender"],
        auth['credentials']['token'],
        Time.at(auth['credentials']['expires_at'])
      )
      return login
    end
  end

  def self.with_access_token!(fb_token, fb_expires_at)
    return :invalid if fb_token.blank?
    fb_expires_at = fb_expires_at ? Time.at(fb_expires_at) : 1.month.from_now

    transaction do
      fb_api = Koala::Facebook::API.new(fb_token)
      me = fb_api.get_object('me')

      login = Login.where(provider: 'facebook', uid: me["id"]).first_or_initialize
      login.update_with_facebook_data!(
        me["name"],
        me["gender"],
        fb_token,
        fb_expires_at
      )
      return login
    end
  end

  def auth
    return :auth_nil if auth_s.nil?
    JSON.load(auth_s)
  end

  def update_with_facebook_data!(name, gender, token, expires_at)
    self.build_user if new_record?
    #      
    self.user.name          = name
    self.user.gender        = gender
    self.user.fb_id         = self.uid
    self.user.fb_token      = token
    self.user.fb_expires_at = expires_at
    #last login at
    self.user.last_login_at = Time.now
    #take a look at the 3 lines below with .persisted?
    self.save!
    self.user.save!
    self.user.touch #expires all cache that users user.updated_at
    #stores friend self
    #list.user.store_fb_friends!
    Stalker.enqueue('login.continue', user_id: user_id.to_s)
  end

end
