class V1::UsersController < V1::BaseController
  
  def index
  	return render json: {error: {message: "this operation requires user_ids param separated between underscores. example: 1_12_312_4", code: 2001}} if params[:user_ids].blank?
  	users = User.where(id: params[:user_ids].split('_'))
  	render json: V1::UserPresenter.array(users)
  end

  def show
  	render json: V1::UserPresenter.new(user)
  end

  def posts
  	posts = user.posts(params.slice(:limit, :before))
  	render json: V1::PostPresenter.array(posts)
  end

  private

  def user
  	@user ||= User.find(params[:id])
  end

end
