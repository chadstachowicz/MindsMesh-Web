class V1::SessionController < V1::BaseController

  skip_before_filter :authenticate, only: :login

  def login
    login = Login.with_access_token!(params[:fb_access_token], params[:fb_expires_at])
    if login == :invalid
      render json: {error: {message: "fb_access_token is invalid", code: 1003}}, status: :unauthorized
    else
      render json: V1::UserPresenter.new(login.user).as_me
    end
  end

  def me
    render json: V1::UserPresenter.new(@current_user).as_me
  end
end
