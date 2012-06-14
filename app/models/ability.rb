class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    return guest unless current_user
    #
    can [:read], User do |user|
      current_user == user
    end
    #
    user      if current_user.user?
    student   if current_user.student?
    moderator if current_user.moderator?
    teacher   if current_user.teacher?
    admin     if current_user.admin?
    master    if current_user.master?

  end

  def guest
    can :home_guest
  end

  def user
    can :home_user
  end

  def student
    can :home_student
  end

  def moderator
    can :home_moderator
  end

  def teacher
    can :home_teacher
  end

  def admin
    can :home_admin
  end

  def master
    can :home_master
    can :manage, :all
    cannot :destroy, User
  end

end