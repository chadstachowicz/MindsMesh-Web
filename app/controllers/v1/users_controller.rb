class V1::UsersController < V1::BaseController
=begin
  def batch
  	return render json: {error: {message: "this operation requires user_ids param separated between underscores. example: 1_12_312_4", code: 2001}}, status: :not_acceptable if params[:user_ids].blank?
  	users = User.where(id: params[:user_ids].split('_'))
  	render json: V1::UserPresenter.array(users)
  end
=end

  def show
    render json: V1::UserPresenter.new(user)
  end

  def with_children
    render json: V1::UserPresenter.new(user).with_children
  end

  def posts
  	posts = user.posts(params.slice(:limit, :before))
  	render json: V1::PostPresenter.array(posts)
  end

  def posts_with_parents
    posts = user.posts.as_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts).map(&:with_parents)
  end


  private

  def user
  	@user ||= User.find(params[:id])
  end

end
