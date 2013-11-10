class Mailtest < ActionMailer::Base

  default from: "aarkerio@outlook.com"

  def welcome_email
    mail(:to => 'mmontoya@gmail.com', :subject => "All os OK!", :body => "Body mail lorem ipsum doloret amet" ).deliver
  end
end
