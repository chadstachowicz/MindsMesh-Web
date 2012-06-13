class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    current_user ||= User.new # user with no roles

    can [:read], User do |user|
      current_user == user
    end

    if current_user.master?
      can [:manage], User
      can [:manage], School
    end
  end
end