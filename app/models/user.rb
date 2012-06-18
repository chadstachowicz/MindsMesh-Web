class User < ActiveRecord::Base
  attr_accessible :name, :photo_url, :roles_s
  has_many :logins
  has_many :school_user_requests
  has_many :school_users
  has_many :section_users
  has_many :posts
  validates_presence_of :name

  ROLES = %w(guest user student moderator teacher admin master)

  def roles
    roles_s.to_s.split.map &:to_s
  end

  def roles=(roles)
    self.roles_s = roles.compact.join(' ')
  end

  def role?(*given_roles)
    given_roles = given_roles.map(&:to_s)
    return false if given_roles.size == 1 && given_roles.include?('user')
    given_roles.each do |given_role|
      raise "unknown #{given_role} role" unless ROLES.include?(given_role)
      return true if roles.include?(given_role)
    end
    false
  end

  def guest?;     false;             end #when you don't have a current_user, it's a guest
  def user?;      roles.empty?;      end #must have zero roles to be a user
  def student?;   role?(:student);   end
  def moderator?; role?(:moderator); end
  def teacher?;   role?(:teacher);   end
  def admin?;     role?(:admin);     end
  def master?;    role?(:master);    end


  def posts_feed
    Post.where(section_id: section_users.map(&:section_id)).order("id DESC").limit(50)
  end
end
