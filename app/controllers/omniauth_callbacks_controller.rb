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
    
    def google_oauth2
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
        
        if @user.persisted?
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
            sign_in_and_redirect @user, :event => :authentication
            else
            session["devise.google_data"] = request.env["omniauth.auth"]
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