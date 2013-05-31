class HomeController < ApplicationController

  load_and_authorize_resource class: false

  def denied
    redirect_to_landing_home_page
  end
    
  def search_users
      users = User.joins(:entity_users).where('entity_users.entity_id in (?) and name like ?', current_user.entity_users.map(&:entity_id),"%#{params[:query]}%").uniq.limit(8)
      groups = Group.where('entity_id in (?) and name like ?', current_user.entity_users.map(&:entity_id),"%#{params[:query]}%").uniq.limit(8)
      render :json => {:users => users, :groups => groups}
  end

  def fb_canvas
    if params[:signed_request]
      Resque.enqueue(FacebookApprequestsClear, params[:signed_request])
      logger.info "Resque.enqueue(FacebookApprequestsClear, signed_request: ...)"
    else
      session[:must_clear_fb_apprequests] = true
      logger.info "session[:must_clear_fb_apprequests] = true"
    end
    #should not use this oauth to log user in, it expires in a few hours
    #redirecting to facebook is the right way
    return redirect_to '/users/auth/facebook' if current_user.nil?

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
    @type = 'post'
    @posts = current_user.posts_feed
  end

  def ajax_application
  end

  def login
    render layout: 'home_guest'
  end
    
  def ucmesh_login
    render layout: 'ucmesh_home_guest'
  end
    
  def edumesh_login
    render layout: 'edumesh_home_guest'
  end

  def entities
  end
    
  def create_signup_request
      #     email = params[:email]
      #entity = Entity.find_by_email_domain(email)
      #if entity.nil?
      #  entity = Entity.new(:domains => ("|" + email.downcase.split('@').last + "|"))
      #  entity.save
      #end
      sr = SignupRequest.where(email: params[:signup_request][:email]).first_or_initialize
        sr.generate_and_mail_new_token
        text = sr.save ? "a confirmation email has been sent to #{params[:signup_request][:email]}" : sr.errors.full_messages.to_sentence.to_s
        render text: text
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
    
  def confirm_signup_request
     @srr = SignupRequest.find_by_confirmation_token!(params[:confirmation_token])
     #for user logged in
    
     sr = @srr.confirm
     @entity = Entity.find_by_email_domain(@srr.email)
     if (!@entity.nil?)
         @eu = @entity.entity_users.order("RAND()").limit(21)
     end
      
      render :layout => 'pages'
  end

  def topics
  end
    
    def groups
    end

  def change_access_token
    current_user.change_access_token
    current_user.save
    render nothing: true
  end
    
        def saml
            settings = Onelogin::Saml::Settings.new
            settings.assertion_consumer_service_url = "https://test.mindsmesh.com:3000/users/auth/saml/callback"
            settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
            settings.issuer = "http://DC2012MM.MINDSMESH.COM/adfs/services/trust"
            settings.idp_sso_target_url = "https://test.mindsmesh.com:3000/users/auth/saml/callback"
            settings.idp_cert_fingerprint = "6d:68:ca:7c:e9:bf:c3:13:56:83:11:5e:0f:77:7e:3d:02:d8:34:80"
            meta = Onelogin::Saml::Metadata.new
            render :xml => meta.generate(settings)
        end


  def create_post
    begin
      @post = Post.create! params[:post]
      params[:files] and params[:files].values.each do |file|
        PostAttachment.my_create_file!(@post, file)
      end
    rescue => e
      flash[:alert] = e.message
    end
    redirect_to :back
  end

    def create_message
        begin
            @message = Message.create! params[:message]
            params[:files] and params[:files].values.each do |file|
                MessageAttachment.my_create_file!(@post, file)
        end
            rescue => e
            flash[:alert] = e.message
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
