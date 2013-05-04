class Ability
  include CanCan::Ability

  def everybody
    can [:denied, :fb_canvas, :confirm_entity_request], :home
  end

  def not_logged_in
      can [:login, :ucmesh_login, :edumesh_login], :home
  end

  def logged_in
      can [:admin, :entities, :create_entity_request, :change_access_token, :ajax_application, :search_users], :home
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

      can [:show, :more_posts, :follow, :unfollow], User
  end

  def index
      can [:index, :create_post, :more_posts, :feedback, :topics, :groups], :home

    #TODO: stop testing only as a master
    can [:create, :filter], Topic
    can [:show, :join, :leave], Topic do |topic|
      topic.entity.entity_users.where(user_id: @current_user.id).exists?
    end
      can [:show, :join, :leave], Group do |group|
          group.entity.entity_users.where(user_id: @current_user.id).exists?
      end
    #TODO: stop testing only as a master
      can [:more_posts], Topic do |topic|
      topic.topic_users.where(user_id: @current_user.id).exists?
    end
      can [:more_posts], Group do |group|
          group.group_users.where(user_id: @current_user.id).exists?
      end
    can [:read, :create_reply], Post do |post|
      true ==true
    end
    can [:update, :destroy], [Post, Reply] do |msg|
      msg.user_id == @current_user.id
    end
    can [:destroy], [PostAttachment] do |pa|
      pa.post.user_id == @current_user.id
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