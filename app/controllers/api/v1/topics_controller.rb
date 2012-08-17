module Api::V1
  class TopicsController < BaseController

=begin 
  def batch
  	return render json: {error: {message: "this operation requires topic_ids param separated between underscores. example: 1_12_312_4", code: 4001}}, status: :not_acceptable if params[:topic_ids].blank?
  	topics = Topic.where(id: params[:topic_ids].split('_'))
  	render json: V1::TopicPresenter.array(topics)
  end
=end

    def create
      topic = Topic.create!(params[:topic])
      topic.entity_user_join(topic.entity_user)
      render json: TopicPresenter.new(topic)
    end

    def show
      render json: TopicPresenter.new(topic)
    end

    def posts
    	posts = topic.posts(params.slice(:limit, :before))
    	render json: PostPresenter.array(posts)
    end

    def posts_with_parents
      posts = topic.posts.as_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).map(&:with_parents)
    end

    def join
      eu = EntityUser.eu(topic.entity_id, @current_user.id)
      tu = topic.entity_user_join(eu)
      render json: tu.persisted?
    end

    def leave
      eu = EntityUser.eu(topic.entity_id, @current_user.id)
      tu = topic.entity_user_leave(eu)
      render json: !tu.persisted?
    end

    private

    def topic
    	@topic ||= Topic.find(params[:id])
    end
  end
end