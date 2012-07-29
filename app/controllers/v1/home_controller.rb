class V1::HomeController < V1::BaseController

  def posts
    posts = @current_user.posts_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts)
  end

  def posts_with_parents
    posts = @current_user.posts_feed(params.slice(:limit, :before))
    render json: V1::PostPresenter.array(posts).map(&:with_parents)
  end

  def entities
    entities = @current_user.entities
    render json: V1::EntityPresenter.array(entities)
  end

  def entities_with_children
    entities = @current_user.entities
    render json: V1::EntityPresenter.array(entities).map { |ep| ep.with_topics_and_topic_users(@current_user) }
  end

  def topics
    topics = @current_user.topics
    render json: V1::TopicPresenter.array(topics)
  end

  def search_topics
    topics = @current_user.search_topics(params[:q])
    render json: V1::TopicPresenter.array(topics)
  end

end
