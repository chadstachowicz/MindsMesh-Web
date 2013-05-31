class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.params"]["confirmation_token"])
        
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
            else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
    
    def edu_facebook
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.params"]["confirmation_token"])
        
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
            else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
    
    def saml
        p request.env["omniauth.auth"]
        redirect_to_landing_home_page
    end
    
    def twitter
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user, request.env["omniauth.params"]["confirmation_token"])
        
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
            else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
end