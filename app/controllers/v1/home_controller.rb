class V1::HomeController < V1::BaseController

  before_filter :authenticate

  def posts
    posts = @current_user.posts_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts)
  end

  def posts_with_parents
    posts = @current_user.posts_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts).map(&:with_parents)
  end

end
