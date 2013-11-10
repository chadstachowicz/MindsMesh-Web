
# MindsMesh (c) 2013

class MyMail < ActionMailer::Base

  default from: "mindsmesh@mindsmesh.com"

  def mail_test
    @subject    = "Test mailer MindsMesh"
    mail( to: 'test@mindsmesh.com', bcc: "mmontoya@gmail.com", subject: @subject, body: "Test body" ).deliver
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mail.confirmation.subject
  #
  def confirmation(entity_user_request)
    
    @user  = entity_user_request.user
    logger.debug  "\n  entity_user_request.confirmation_token:" +  entity_user_request.confirmation_token + "\n"
    @link  = home_confirm_entity_request_url(entity_user_request.confirmation_token, host: host)

    mail( to: entity_user_request.email, subject: "Welcome to MindsMesh!").deliver
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

  private

  def host
    Settings.env['domain']
  end

end

