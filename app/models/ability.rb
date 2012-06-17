class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    return guest unless current_user
    @current_user = current_user
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

    # TODO: admin can manage/destroy SectionUser in their school
    # TODO: teacher can manage/destroy SectionUser in section they are moderator
    # TODO: moderator can destroy SectionUser in section they are moderator if it has no privileges
    can [:destroy], Post do |post|
      post.user_id == current_user.id
    end
  end

  def guest
    can :home_guest
  end

  def user
    can :home_user
  end

  def student
    can :home_student
    can [:read, :join], Section do |section|
      section.school.school_users.where(user_id: @current_user.id).exists?
    end
    can [:create_post], Section do |section|
      User.logger.info "CAN create_post @section ?"
      section.section_users.where(user_id: @current_user.id).exists?
    end
  end

  def moderator
    can :home_moderator
    #they are considered students in the sections they are in
    #but that logic is not being invoked here
  end

  def teacher
    can :home_teacher
    #they are considered students in the sections they are in
    #but that logic is not being invoked here
  end

  def admin
    can :home_admin
    can :manage, Section
    cannot :destroy, Section
  end

  def master
    can :home_master
    can :manage, :all
    cannot :destroy, User
  end

end