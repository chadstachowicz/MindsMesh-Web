class HomeController < ApplicationController

  authorize_resource class: false

  def denied
    redirect_to_landing_home_page
  end

  def fb_canvas
    return redirect_to '/auth/facebook' if params[:fb_source]
    redirect_to_landing_home_page
  end

  def index
    redirect_to_landing_home_page
    @posts = current_user.posts_feed
  end

  def login
    render layout: 'home_guest'
  end

  def entities
  end

  def create_entity_request
    entity_uncc = Entity.find_by_slug('uncc')
    eur = current_user.entity_user_requests.where(entity_id: entity_uncc.id, email: params[:email]).first_or_initialize
    eur.generate_and_mail_new_token
    text = eur.save ? 'true' : eur.errors.full_messages.to_sentence.to_s
    render text: text
  end

  def confirm_entity_request
    eur = EntityUserRequest.find_by_confirmation_token!(params[:confirmation_token])
    #for user logged in
    eu = eur.confirm
    session[:user_id] = eu.user_id
    redirect_to :root
  end

  def topics
  end

  def change_access_token
    current_user.change_access_token
    current_user.save
    render nothing: true
  end

  def create_post
    @post = Post.create!(params[:post])
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
