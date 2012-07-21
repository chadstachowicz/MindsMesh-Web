class V1::PostsController < V1::BaseController

  def show
    render json: V1::PostPresenter.new(post)
  end

  def with_children
    render json: V1::PostPresenter.new(post).with_children
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end
end
