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
    can :home_client
    #TODO: stop testing only as a master
    can [:create], Topic
    can [:show, :join, :leave], Topic do |topic|
      topic.entity.entity_users.where(user_id: @current_user.id).exists?
    end
    #TODO: stop testing only as a master
    can [:more_posts], Topic do |topic|
      topic.topic_users.where(user_id: @current_user.id).exists?
    end
    can [:read, :create_reply], Post do |post|
      post.topic.topic_users.where(user_id: @current_user.id).exists?
    end
    can [:update, :destroy], [Post, Reply] do |msg|
      msg.user_id == @current_user.id
    end
    can [:show], Notification do |notification|
      notification.user_id == @current_user.id
    end
  end

  def master
    #can :home_master
    can :manage, :all
    cannot :destroy, User
  end

end