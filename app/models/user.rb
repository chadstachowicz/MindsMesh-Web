class User < ActiveRecord::Base
  attr_accessible :name
  has_many :logins,               dependent: :destroy
  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users,         dependent: :destroy
  has_many :topic_users,          dependent: :destroy
  has_many :posts,                dependent: :destroy
  has_many :replies,              dependent: :destroy
  has_many :likes,                dependent: :destroy
  has_many :notifications,        dependent: :destroy

  has_many :entities, through: :entity_users

  validates_presence_of :name
  validates_presence_of :fb_id
  validates_presence_of :fb_token
  validates_presence_of :fb_expires_at

  before_create :change_access_token
  after_create :joins_self_joining_entities

  def change_access_token
    self.access_token = Digest::MD5.hexdigest(Time.now.to_s+rand(999).to_s)
  end

  ROLES = {
            master:    4,
            admin:     3,
            manager:   2,
            moderator: 1
          }

  def role
    ROLES.key(role_i)
  end

  def role=(given_role)
    self.role_i = 0 if given_role.nil?
    self.role_i = ROLES[given_role.to_sym] || 0
  end

  def moderator?; role_is?(:moderator); end
  def manager?;   role_is?(:manager);   end
  def admin?;     role_is?(:admin);     end
  def master?;    role_is?(:master);    end

  def photo_url
    return "/assets/user.jpg" unless Rails.env.production?
    "https://graph.facebook.com/#{fb_id}/picture?type=square"
  end

  def fb_api
    return :expired if fb_expires_at < Time.now
    @fb_api ||= Koala::Facebook::API.new(fb_token)
  end

  def posts_feed(options={})
    topic_ids = topic_users.map(&:topic_id)
    return [] if topic_ids.empty?
    Post.where(topic_id: topic_ids).as_feed(options)
  end

  private

  def joins_self_joining_entities
    Entity.self_joinings.each { |e| e.user_join!(self) }
  end

  #user matches the mininum requirement
  def role_is?(given_role_i)
    role_i >= User::ROLES[given_role_i]
  end
end
