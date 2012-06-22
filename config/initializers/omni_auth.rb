Rails.application.config.middleware.use OmniAuth::Builder do
  fb = Settings.env["facebook"]
  provider "facebook", fb["key"], fb["secret"], fb["options"]
  unless Rails.env.production?
    
    domain = Settings.env["domain"]
    fb_data =  {uid: '12345',
                info: { email: 'bob@example.com',
                        link: 'http://facebook.com/bob',
                        gender: 'male',
                        image: "http://#{domain}/assets/profile-photo.jpg"
                      }
               }

    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock('facebook', fb_data)
  end
end