class User < ActiveRecord::Base
  attr_accessible :name, :photo_url, :roles_s
  has_many :logins
  validates_presence_of :name

  def roles
    roles_s.to_s.split.map &:to_sym
  end

  def user?;      roles.empty?;               end
  def student?;   roles.include?(:student);   end
  def moderator?; roles.include?(:moderator); end
  def teacher?;   roles.include?(:teacher);   end
  def admin?;     roles.include?(:admin);     end
  def master?;    roles.include?(:master);    end

end
