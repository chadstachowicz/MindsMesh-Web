module Api::V1
  class SessionController < BaseController

    skip_before_filter :authenticate, only: :login

    def login
      if params[:fb_access_token].nil?
          user = User.find_for_database_authentication(:email => params[:email])
          return false unless user
          
           if user.valid_password?(params[:password])
               render json: UserPresenter.new(user).as_me

           else
               render json: {error: {message: "fb_access_token is invalid", code: 1003}}, status: :unauthorized
           end
      else
        
          
      user = Login.with_access_token!(params[:fb_access_token], params[:fb_expires_at])
     end
        if user == :invalid
            render json: {error: {message: "fb_access_token is invalid", code: 1003}}, status: :unauthorized
            else
            render json: UserPresenter.new(user).as_me
        end
    end

    def me
      render json: UserPresenter.new(@current_user).as_me
    end
  end
end