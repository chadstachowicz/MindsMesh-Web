class HomeController < ApplicationController
  def denied
    redirect_to_landing_home_page
  end

  def client
    return redirect_to_landing_home_page unless current_user
    authorize! :home_client, nil
    @posts = current_user.posts_feed
  end

  def guest
    authorize! :home_guest, nil
    render layout: 'home_guest'
  end

  def user
    authorize! :home_user, nil
  end

  def user_create_eur
    authorize! :home_user, nil
    entity_uncc = Entity.find_by_slug('uncc')
    eur = current_user.entity_user_requests.where(entity_id: entity_uncc.id, email: params[:email]).first_or_initialize
    eur.generate_and_mail_new_token
    text = eur.save ? 'true' : eur.errors.full_messages.to_sentence.to_s
    render text: text
  end

  def user_entity
    eur = EntityUserRequest.find_by_confirmation_token!(params[:confirmation_token])
    #for user logged in
    session[:user_id] = eur.confirm
    redirect_to_landing_home_page
  end
=begin
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
=end
  def create_post
    topic_user = current_user.topic_users.find(params[:topic_user_id])
    @post = Post.create_with!(topic_user, params[:post])
    render @post
  end

  def more_posts
    @posts = current_user.posts_feed(params.slice(:limit, :before))
    render '/posts/more_posts', layout: false
  end

  def feedback
    feedback_questionaire = Questionnaire.where(user_id: current_user.id).first_or_initialize
    feedback_questionaire.update_attribute(params[:name], params[:value])
    render nothing: true
  end
end
