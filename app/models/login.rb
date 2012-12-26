require 'stalker'
class Login < ActiveRecord::Base
  belongs_to :user
  attr_accessible :auth_s, :provider, :uid
  validates_presence_of :provider
  validates_presence_of :uid
  #validates_presence_of :auth_s

  def self.auth!(auth)
    raise "invalid facebook login" if auth.nil?
    
    # user = nil
    # transaction do
    user = User.where(fb_id: auth["uid"].to_s).first_or_initialize

    user.save_with_facebook_data!(
      auth["uid"],
      auth["info"]["name"],
      auth["info"]["gender"],
      auth['credentials']['token'],
      Time.at(auth['credentials']['expires_at'])
    )
    # end
    Stalker.enqueue('login.continue', user_id: user.id.to_s)
    return user
  end

  def self.with_access_token!(fb_token, fb_expires_at)
    return :invalid if fb_token.blank?
    fb_expires_at = fb_expires_at ? Time.at(fb_expires_at.to_i) : 1.month.from_now

    # login = nil
    # transaction do
    fb_api = Koala::Facebook::API.new(fb_token)
    me = fb_api.get_object('me')

    user = User.where(fb_id: me["id"]).first_or_initialize
    #login = Login.where(provider: 'facebook', uid: me["id"]).first_or_initialize
    user.save_with_facebook_data!(
      me["id"],
      me["name"],
      me["gender"],
      fb_token,
      fb_expires_at
    )
    # end
    Stalker.enqueue('login.continue', user_id: user.id.to_s)
    return user
  end

  def auth
    return :auth_nil if auth_s.nil?
    JSON.load(auth_s)
  end

  # def update_with_facebook_data!(name, gender, token, expires_at)
  #   self.build_user if new_record?
  #   #      
  #   self.user.name          = name
  #   self.user.gender        = gender
  #   self.user.fb_id         = self.uid
  #   self.user.fb_token      = token
  #   self.user.fb_expires_at = expires_at
  #   #take a look at the 3 lines below with .persisted?
  #   self.save!
  #   self.user.save!
  #   self.user.touch #expires all cache that users user.updated_at
  #   #stores friend self
  #   #list.user.store_fb_friends!
  # end

end
