class V1::TopicsController < V1::BaseController

=begin 
  def batch
  	return render json: {error: {message: "this operation requires topic_ids param separated between underscores. example: 1_12_312_4", code: 4001}}, status: :not_acceptable if params[:topic_ids].blank?
  	topics = Topic.where(id: params[:topic_ids].split('_'))
  	render json: V1::TopicPresenter.array(topics)
  end
=end

  def show
  	render json: V1::TopicPresenter.new(topic)
  end

  def posts
  	posts = topic.posts(params.slice(:limit, :before))
  	render json: V1::PostPresenter.array(posts)
  end

  def posts_with_parents
    posts = topic.posts.as_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts).map(&:with_parents)
  end

  private

  def topic
  	@topic ||= Topic.find(params[:id])
  end
end