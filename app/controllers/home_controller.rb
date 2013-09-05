class HomeController < ApplicationController
    
  load_and_authorize_resource class: false
    
  def denied
    redirect_to_landing_home_page
  end
    
  def search_users
      users = User.joins(:entity_users).where('entity_users.entity_id in (?) and name like ?', current_user.entity_users.map(&:entity_id),"%#{params[:query]}%").uniq.limit(8)
      users.each do |user|
          user["photo_url"] = User.find(user.id).photo_url
       end
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
    eu = current_user.entity_users.first
    ent = EntityAdvancedSetting.find_by_entity_id(eu.entity_id)
    if !ent.nil?
        if ent.can_create_topic == 1
            @hidetopic = 1
        end
    end
    if current_user.current_sign_in_at.nil? || current_user.current_sign_in_at < 7.days.ago
        # cookies['suggest_follows'] = "true"
    elsif current_user.current_sign_in_at.nil? || current_user.current_sign_in_at < 3.days.ago
        # cookies['suggest_invites'] = "true"
    end
    @type = 'post'
      if params[:type] == 'following'
          @posts = current_user.posts_feed({},true)
      else
          @posts = current_user.posts_feed({},false)
      end
                                           
    
    redirect_to_landing_home_page
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
      sr = SignupRequest.where(email: params[:signup_request][:email]).first_or_initialize
        sr.generate_and_mail_new_token
        text = sr.save ? "a confirmation email has been sent to #{params[:signup_request][:email]}" : sr.errors.full_messages.to_sentence.to_s
        render text: text
  end

  def create_entity_request
    entity = Entity.find_by_email_domain(params[:email])
    return render text: entity if entity.is_a? String
    eur = EntityUserRequest.where(entity_id: entity.id, email: params[:email]).first_or_initialize
    eur.user_id = current_user.id
    eur.generate_and_mail_new_token
    text = eur.save ? "a confirmation email has been sent to #{params[:email]}" : eur.errors.full_messages.to_sentence.to_s
    render text: text
  end

  def confirm_entity_request
    eur = EntityUserRequest.find_by_confirmation_token!(params[:confirmation_token])
    user = User.find_by_email(eur.email)
    if user.nil?
        #for user logged in
        eu = eur.confirm
        user = User.find(eu.user_id)
        user.email = eur.email
        user.save
        sign_in user
    else
        euser = User.find(eur.user_id)
        user.attributes = euser.attributes
        user.email = eur.email
        user.save
        sign_in user
    end
      roster = Roster.find_all_by_email(eur.email)
      if !roster.nil?
          roster.each do |cls|
              tu = TopicUser.where(:user_id => user.id, :topic_id => cls.topic_id).first_or_initialize
              tu.role_i = cls.role
              tu.save
          end
       end
          entity = Entity.find_by_email_domain(eur.email)
          eur = user.entity_user_requests.where(entity_id: entity.id, email: eur.email).first_or_initialize
          eur.save
         eur.confirm
      #    text = "#{current_user.name} #joined the #{entity.name} network.  Take a moment to welcome them."
      #    @post = Post.where(:text => text, :user_id => user.id).create
      #    @tags = @post.text.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
      #    if !@tags.nil?
      #          @tags.each do |tag|
      #              hashtag = Hashtag.where(:name => tag[0]).first_or_create
      #              HashtagsPost.create(:post_id => @post.id, :hashtag_id => hashtag.id)
      #          end
      #      end
                                
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
                                            
    render :action => 'join_entity', :layout => 'pages_no_login'
  end
                                            
  def join_entity
    @entity = Entity.find_by_token(params[:token])
    puts @entity.name
    if (!@entity.nil?)
        @eu = @entity.entity_users.order("RAND()").limit(21)
    end
    
    render :action => 'join_entity', :layout => 'pages_no_login'
                                    
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
      @tags = @post.text.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
        if !@tags.nil?
            @tags.each do |tag|
            hashtag = Hashtag.where(:name => tag[0]).first_or_create
            HashtagsPost.create(:post_id => @post.id, :hashtag_id => hashtag.id)
           end
        end
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
            message_thread_ids = params[:message_receiver_ids].split(/,/)
            message_thread_ids << params[:message][:user_id]
            # create a new thread
            thread = MessageThread.create(user_id: current_user.id)

            # add each User to the thread_participants table
            message_thread_ids.each do |t|
                ThreadParticipant.create(:message_thread_id => thread.id, :user_id => t.to_i)
            end

            # create a new Message and add the MessageThread that it belongs to
            @message = Message.new(params[:message])
            @message.message_thread_id = thread.id
            @message.save
                
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
