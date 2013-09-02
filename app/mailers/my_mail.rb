class MyMail < ActionMailer::Base
  default from: "welcome@mindsmesh.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mail.confirmation.subject
  #
  def confirmation(entity_user_request)
    @user  = entity_user_request.user
    @link  = home_confirm_entity_request_url(entity_user_request.confirmation_token, host: host)

    mail to: entity_user_request.email, subject: "Welcome to MindsMesh!"
  end
    
    def signup_confirmation(signup_request)
        @link  = home_confirm_signup_request_url(signup_request.confirmation_token, host: 'edumesh.com')
        
        mail to: signup_request.email, subject: "MindsMesh confirmation email!"
    end

  def notify_new_reply(user, post, email)
    @user = user
    @post = post
    @host  = host

    mail to: email, subject: "You have a new answer on MindsMesh!"
  end

  def invite(invite_request, email)
    @invite_request = ir = invite_request
    @subject    = "Your friend #{ir.user.name} has invited you to study for #{ir.topic.title} on MindsMesh.com"
    @link       = nice_invite_request_url(@invite_request, @invite_request.user.name.parameterize, host: host)
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
