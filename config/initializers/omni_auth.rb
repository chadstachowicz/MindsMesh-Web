OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  fb = Settings.env["facebook"]
  provider "facebook", fb["key"], fb["secret"], fb["options"]
  unless Rails.env.production?
    
    domain = Settings.env["domain"]
    fb_mock = {
                uid: '12345',
                info: {
                        gender: 'male',
                        name: "Bob Example"
                },
                credentials: {
                  token: "AAAAAAAA",
                  expires_at: 3.months.ago.to_i,
                  expires: true
                }
              }

    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock('facebook', fb_mock)
  end
end