class HomeController < ApplicationController
  def index
    redirect_to_landing_home_page
  end

  def basic
    authorize! :home_basic, nil
  end

  def guest
    authorize! :home_guest, nil
    @entity = Entity.first
    @entity_user_request = @entity.entity_user_requests.build
  end

  def guest_create_eur
    authorize! :home_guest, nil
    @entity_user_request = current_user.entity_user_requests.where(params[:entity_user_request]).first_or_initialize
    @entity_user_request.generate_and_mail_new_token
    @entity_user_request.save
  end

  def user_entity
    eur = EntityUserRequest.find_by_confirmation_token!(params[:confirmation_token])
    session[:user_id] = eur.confirm
    redirect_to_landing_home_page
  end

  def user
    authorize! :home_user, nil
    @posts = current_user.posts_feed
  end

  def moderator
    authorize! :home_moderator, nil
  end

  def manager
    authorize! :home_manager, nil
  end

  def admin
    authorize! :home_admin, nil
  end

  def master
    authorize! :home_master, nil
  end

  def create_post
    topic_user = current_user.topic_users.find(params[:topic_user_id])
    @post = Post.create_with!(topic_user, params[:post])
    render @post
  end

  def more_posts
    @posts = current_user.posts_feed(params.slice(:limit, :before))
    render '/posts/more_posts', layout: false
  end
end
