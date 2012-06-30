class User < ActiveRecord::Base
  attr_accessible :name, :photo_url, :roles_s
  has_many :logins
  has_many :entity_user_requests
  has_many :entity_users
  has_many :topic_users
  has_many :posts
  has_many :replies
  has_many :likes
  validates_presence_of :name

  ROLES = %w(guest user client moderator manager admin master)

  def roles
    roles_s.to_s.split.map &:to_s
  end

  def roles=(roles)
    self.roles_s = roles.compact.join(' ')
  end

  def role?(*given_roles)
    given_roles = given_roles.map(&:to_s)
    return false if given_roles.size == 1 && given_roles.include?('guest')
    given_roles.each do |given_role|
      raise "unknown #{given_role} role" unless ROLES.include?(given_role)
      return true if roles.include?(given_role)
    end
    false
  end

  def guest?;     false;             end #when you don't have a current_user, it's a guest
  def user?;      roles.empty?;      end #must have zero roles to be a user
  def client?;    role?(:client);    end
  def moderator?; role?(:moderator); end
  def manager?;   role?(:manager);   end
  def admin?;     role?(:admin);     end
  def master?;    role?(:master);    end


  def posts_feed(options={})
    Post.where(topic_id: topic_users.map(&:topic_id)).as_feed(options)
  end
end
