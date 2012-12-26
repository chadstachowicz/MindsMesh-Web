module Api::V1
  class SessionController < BaseController

    skip_before_filter :authenticate, only: :login

    def login
      user = Login.with_access_token!(params[:fb_access_token], params[:fb_expires_at])
      if user == :invalid
        render json: {error: {message: "fb_access_token is invalid", code: 1003}}, status: :unauthorized
      else
        user.login_logs.create!(user_agent: request.user_agent)
        render json: UserPresenter.new(user).as_me
      end
    end

    def me
      render json: UserPresenter.new(@current_user).as_me
    end
  end
end