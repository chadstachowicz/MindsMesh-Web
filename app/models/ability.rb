class Ability
  include CanCan::Ability

  def everybody
    can [:denied, :fb_canvas, :confirm_entity_request], :home
  end

  def not_logged_in
    can [:login], :home
  end

  def logged_in
    can [:entities, :create_entity_request, :change_access_token], :home
  end
  
  def initialize(current_user)
    everybody
    return not_logged_in unless current_user
    @current_user = current_user
    #
    logged_in
    return if current_user.entity_users.size.zero?


    index
    master    if current_user.master?

    # TODO: admin can manage/destroy TopicUser in their entity
    # TODO: teacher can manage/destroy TopicUser in topic they are moderator
    # TODO: moderator can destroy TopicUser in topic they are moderator if it has no privileges
    can [:destroy], Post do |post|
      post.user_id == current_user.id
    end

    can [:show, :more_posts], User
  end

  def index
    can [:index, :create_post, :more_posts, :feedback, :topics], :home

    #TODO: stop testing only as a master
    can [:create, :filter], Topic
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
    can [:destroy], [PostAttachment] do |pa|
      pa.user_id == @current_user.id
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