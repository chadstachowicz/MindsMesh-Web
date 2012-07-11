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
  validates_presence_of :name
  validates_presence_of :fb_id
  validates_presence_of :fb_token
  validates_presence_of :fb_expires_at

  after_create :joins_self_joining_entities

  ROLES_MAP = {
                master:    16,
                admin:     8,
                manager:   4,
                moderator: 2,
                client:    1,
                user:      0
              }

  def roles
    r = []
    roles_mask2 = roles_mask #|| 0
    User::ROLES_MAP.each do |role, mask|
      if roles_mask2 >= mask
        r << role
        roles_mask2 -= mask
      end
    end
    #puts "roles_mask #{roles_mask} translates: #{r.map &:to_s}".green
    raise "omg!!" if roles_mask2 > 0
    r.map &:to_s
  end

  def roles=(given_roles)
    given_roles = given_roles.compact.map(&:to_sym)
    self.roles_mask = 0
    given_roles.each do |given_role|
      raise "unknown role: #{given_role}" unless User::ROLES_MAP.keys.include?(given_role)
      self.roles_mask += User::ROLES_MAP[given_role]
    end
    #puts "roles: #{given_roles} store as: #{self.roles_mask}".yellow
    self.roles_mask
  end

  def client?;    role_is?(:client);    end
  def moderator?; role_is?(:moderator); end
  def manager?;   role_is?(:manager);   end
  def admin?;     role_is?(:admin);     end
  def master?;    role_is?(:master);    end

  def photo_url
    return "/assets/user.jpg" unless Rails.env.production?
    "https://graph.facebook.com/#{fb_id}/picture?type=square"
  end

  def fb_api
    return false if fb_expires_at < Time.now
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
  def role_is?(given_role)
    roles_mask >= User::ROLES_MAP[given_role]
  end
end
