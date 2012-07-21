class V1::HomeController < V1::BaseController

  before_filter :authenticate

  def posts
  	posts = @me.posts_feed(params.slice(:limit, :before))
  	render json: V1::PostPresenter.array(posts)
  end

end
