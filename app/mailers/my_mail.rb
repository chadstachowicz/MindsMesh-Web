
# MindsMesh (c) 2013

class MyMail < ActionMailer::Base
    
  self.default(from: 'mmontoya@gmail.com')

  def mail_test
    @subject    = "Test mailer MindsMesh"
    mail( to: 'test@mindsmesh.com', bcc: email, subject: @subject, body: "Test body" ).deliver
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mail.confirmation.subject
  #
  def send_newsletter(user, nl)
    
    #@user  = entity_user_request.user
    #logger.debug  "\n  Debug: entity_user_request.confirmation_token:" +  entity_user_request.confirmation_token + "\n" if Rails.env.development?
    #logger.debug  "\n  Debug: host:" +  host + "\n" if Rails.env.development?
    #@link  = home_confirm_entity_request_url(entity_user_request.confirmation_token, host: host)

    #mail( to: user.email, subject: nl.title, body:nl.body)
    mail( to: 'mmontoya@gmail.com', subject: nl.title, body:nl.htmlemail.html_safe)
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mail.confirmation.subject
  #
  def confirmation(entity_user_request)
    
    @user  = entity_user_request.user
    logger.debug  "\n  Debug: entity_user_request.confirmation_token:" +  entity_user_request.confirmation_token + "\n" if Rails.env.development?
    logger.debug  "\n  Debug: host:" +  host + "\n" if Rails.env.development?
    @link  = home_confirm_entity_request_url(entity_user_request.confirmation_token, host: host)

    mail( to: entity_user_request.email, subject: "Welcome to MindsMesh!")
  end

  #  signup_request
  def signup_confirmation(signup_request)
    @link  = home_confirm_signup_request_url(signup_request.confirmation_token, host: 'edumesh.com')
        
    mail to: signup_request.email, subject: "MindsMesh confirmation email!"
  end

  #  New reply
  def notify_new_reply(user, post, email)
    @user = user
    @post = post
    @host  = host

    mail to: email, subject: "You have a new answer on MindsMesh!"
  end

  def invite(invite_request, email)
    @invite_request = ir = invite_request
    tid = ""
    if invite_request.group_id.nil?
        tid = ir.topic.name
    else
        tid = ir.group.name
    end
    @subject    = "#{ir.user.name} has invited you to #{tid} at #{ir.entity.name} on MindsMesh.com"
    @link       = "http://www.mindsmesh.com/join/#{ir.entity.token}"
    @photo_url  = @invite_request.user.photo_url('large')

    mail to: 'noreply@mindsmesh.com', bcc: email, subject: @subject
  end
    
  def invite_elon(user_id)
    @user = User.find(user_id)
    @subject    = "MindsMesh"
    mail to: 'welcome@mindsmesh.com', bcc: @user.email, subject: @subject
  end
   
  def email
    Settings.env['email']  # settings.yml
  end

  private

  def host
    Settings.env['domain']  # settings.yml
  end

  
end

