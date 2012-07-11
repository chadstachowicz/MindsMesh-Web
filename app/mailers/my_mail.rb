class MyMail < ActionMailer::Base
  default from: "noreply@mindsmesh.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mail.confirmation.subject
  #
  def confirmation(entity_user_request)
    @user  = entity_user_request.user
    @token = entity_user_request.confirmation_token
    @host  = Settings.env['domain']

    mail to: entity_user_request.email, subject: "Welcome to MindsMesh!"
  end
end
