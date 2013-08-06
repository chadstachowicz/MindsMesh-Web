class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_messages

  protected

  before_filter do
    logger.info "Custom: #{custom_log_hash}"
    if Rails.env.test? #capybara
      ident = session[:session_id].object_id
      prms  = params.except(:controller, :action)
      ss    = session.except(:flash, :session_id)
      puts "\n#{ident}. #{request.method} #{controller_name}##{action_name}: #{prms}, #{ss}"
    end
  end

  helper_method :current_user, :me, :my_ca

  alias :me :current_user

  def my_ca
    "#{controller_name}##{action_name}"
  end

  def redirect_to_landing_home_page
    return redirect_to '/auth/facebook' if params['signed_request']
    return redirect_to :home_login      unless current_user
    return redirect_to :home_entities   if current_user.entity_users.size.zero?
      #   return redirect_to :home_topics     if current_user.topics.to_a.empty?
    
    return redirect_to :root unless controller_name=='home'&&action_name=='index'
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to denied_url, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound,     with: :render_404
  #rescue_from ActionController::RoutingError,   with: :render_404
  #rescue_from ActionController::UnknownAction,  with: :render_404

  def render_404
    respond_to do |type| 
      type.html { render "errors/404", layout: 'application', status: 404 } 
      type.js   { render nothing: true, status: 404 } 
      type.all  { render nothing: true, status: 404 } 
    end
  end

  private

  def custom_log_hash
    {
      'session' => session.to_hash.except("_csrf_token", 'flash')
    }
  end

  def load_messages
    if user_signed_in?
      sql = "SELECT messages.id, messages.created_at, messages.text, messages.message_thread_id, users.name, users.id, (SELECT message_read_states.read_date FROM message_read_states WHERE message_read_states.message_id = messages.id and message_read_states.user_id = #{current_user.id}) AS ReadState FROM messages INNER JOIN users ON messages.user_id = users.id WHERE ( messages.id in ( SELECT Max(messages.id) FROM thread_participants INNER JOIN messages ON thread_participants.message_thread_id = messages.message_thread_id WHERE thread_participants.user_id = #{current_user.id} GROUP BY thread_participants.message_thread_id)) ORDER BY messages.created_at DESC;"
      @messages= ActiveRecord::Base.connection.execute(sql)

      puts "MESSAGES: #{@messages.to_a}"

      # "SELECT messages.id, messages.created_at, messages.text, messages.message_thread_id, users.name, users.id, 
      #   (
      #     SELECT message_read_states.read_date 
      #     FROM message_read_states 
      #     WHERE message_read_states.message_id = messages.id and message_read_states.user_id = #{current_user.id}
      #   ) AS ReadState 

      #   # This next says from Where it comes
      #   FROM messages 
      #   INNER JOIN users 
      #   ON messages.user_id = users.id 
      #   WHERE ( 
          # messages.id in ( 
          #   SELECT Max(messages.id) 
          #   FROM thread_participants 
          #   INNER JOIN messages 
          #   ON thread_participants.message_thread_id = messages.message_thread_id 
          #   WHERE thread_participants.user_id = #{current_user.id} 
          #   GROUP BY thread_participants.message_thread_id
          # )
      #   ) 

      #   ORDER BY messages.created_at DESC;"

      @ar_messages = Message.select("messages.id, messages.created_at, messages.text, messages.message_thread_id, users.name, users.id")
                            .joins(:user)
                            .where("messages.id in (SELECT Max(messages.id) FROM thread_participants INNER JOIN messages ON thread_participants.message_thread_id = messages.message_thread_id WHERE thread_participants.user_id = #{current_user.id} GROUP BY thread_participants.message_thread_id)")
                            .order("created_at DESC")

      # SELECT id, created_at, text, message_thread_id, users.name, users.id 
      # FROM `messages` INNER JOIN `users` 
      # ON `users`.`id` = `messages`.`user_id` 
      # WHERE (messages.id in (SELECT Max(messages.id) FROM thread_participants INNER JOIN messages ON thread_participants.message_thread_id = messages.message_thread_id WHERE thread_participants.user_id = 2 GROUP BY thread_participants.message_thread_id)) ORDER BY created_at DESC

      puts "AR MESSAGES: #{@ar_messages.to_a}"      

    end
  end

  

end
