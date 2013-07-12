class Ability
  include CanCan::Ability

  def everybody
      can [:denied, :fb_canvas, :confirm_entity_request, :create_signup_request, :confirm_signup_request, :saml], :home
      can [:lti], Entity
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
    school_admin    if current_user.school_admin?
    topic_admin    if current_user.topic_admin?
    group_admin    if current_user.group_admin?

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

  def school_admin
      can [:index], :admin
      can [:index, :datatable_filter], Entity
      can [:index, :datatable_filter], Topic
      can [:edit, :destroy, :update], Topic do |tpc|
          if !@current_user.entity_users.find_by_entity_id(tpc.entity_id).nil?
              @current_user.entity_users.find_by_entity_id(tpc.entity_id).role_i == 1
          end 
      end
      can [:update, :destroy], [Post, Reply]
        cannot :destroy, User
  end
    
    def topic_admin
        can [:index], :admin
        can [:index, :datatable_filter], Topic
        can [:edit, :destroy, :update], Topic do |tpc|
            if !@current_user.topic_users.find_by_topic_id(tpc.id).nil?
                @current_user.topic_users.find_by_topic_id(tpc.id).role_i == 1
            end
        end
        can [:update, :destroy], [Post] do |msg|
            if !@current_user.topic_users.find_by_topic_id(msg.topic_id).nil?
                @current_user.topic_users.find_by_topic_id(msg.topic_id).role_i == 1
            end
                
        end
        cannot :destroy, User
    end
    
    def group_admin
        can [:index], :admin
        can [:update, :destroy], [Post, Reply] do |msg|
            if !@current_user.group_users.find_by_group_id(msg.group_id).nil?
                @current_user.group_users.find_by_group_id(msg.group_id).role_i == 1
            end
            
        end
        cannot :destroy, User
    end

end