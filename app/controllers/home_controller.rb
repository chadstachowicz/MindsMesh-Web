class HomeController < ApplicationController

  authorize_resource class: false

  def denied
    redirect_to_landing_home_page
  end

  def fb_canvas

    if params[:request_ids] && params[:signed_request]
      @oauth=KoalaFactory.new_oauth
      signed_request = @oauth.parse_signed_request(params[:signed_request])
      @graph = KoalaFactory.new_graph(signed_request["oauth_token"])

      @graph.batch do |batch_api|
        params[:request_ids].split(',').each do |request_id|
          full_id = [request_id, signed_request["user_id"]].join('_')
          batch_api.delete_object(full_id)
        end
      end
    end

    return redirect_to '/auth/facebook' if current_user.nil?

    redirect_to_landing_home_page
  end

  def fb_requests_sent
    current_user.fb_friends.where(fb_id: params[:to]).each do |fb_friend|
      fb_friend.update_attribute :last_request_sent_at, Time.now
    end
    render nothing: true
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
    entity = Entity.find_by_email_domain(params[:email])
    return render text: entity if entity.is_a? String
    eur = current_user.entity_user_requests.where(entity_id: entity.id, email: params[:email]).first_or_initialize
    eur.generate_and_mail_new_token
    text = eur.save ? "a confirmation email has been sent to #{params[:email]}" : eur.errors.full_messages.to_sentence.to_s
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
    @post = Post.create! params[:post]
    params[:files] and params[:files].values.each do |file|
      PostAttachment.my_create_file!(@post, file)
    end
    redirect_to :back
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
