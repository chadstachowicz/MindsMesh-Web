module Api::V1
  class SessionController < BaseController

    skip_before_filter :authenticate, only: :login

    def login
      login = Login.with_access_token!(params[:fb_access_token], params[:fb_expires_at])
      if login == :invalid
        render json: {error: {message: "fb_access_token is invalid", code: 1003}}, status: :unauthorized
      else
        render json: UserPresenter.new(login.user).as_me
      end
    end

    def me
      render json: UserPresenter.new(@current_user).as_me
    end
  end
end