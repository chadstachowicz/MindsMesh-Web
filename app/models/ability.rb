class Ability
  include CanCan::Ability

  def guest
    can :home_guest
  end
  
  def initialize(current_user)
    return guest unless current_user
    @current_user = current_user
    #
    user
    client    if current_user.client?
    #moderator if current_user.moderator?
    #manager   if current_user.manager?
    admin     if current_user.admin?
    master    if current_user.master?

    # TODO: admin can manage/destroy TopicUser in their entity
    # TODO: teacher can manage/destroy TopicUser in topic they are moderator
    # TODO: moderator can destroy TopicUser in topic they are moderator if it has no privileges
    can [:destroy], Post do |post|
      post.user_id == current_user.id
    end

    can [:show, :more_posts], User
  end

  def user
    can :home_user
  end

  def client
    can :home_client
    #TODO: stop testing only as a master
    can [:read, :join], Topic do |topic|
      topic.entity.entity_users.where(user_id: @current_user.id).exists?
    end
    #TODO: stop testing only as a master
    can [:read_posts], Topic do |topic|
      topic.topic_users.where(user_id: @current_user.id).exists?
    end
    can [:read], Post do |post|
      post.topic.topic_users.where(user_id: @current_user.id).exists?
    end
    can [:update, :destroy], [Post, Reply] do |msg|
      msg.user_id == @current_user.id
    end
  end
=begin
  def moderator
    can :home_moderator
    #they are considered students in the topics they are in
    #but that logic is not being invoked here
  end

  def manager
    can :home_manager
    #they are considered students in the topics they are in
    #but that logic is not being invoked here
  end
=end
  def admin
    can :home_admin
    can :manage, Topic
    cannot :destroy, Topic
  end

  def master
    #can :home_master
    can :manage, :all
    cannot :destroy, User
  end

end