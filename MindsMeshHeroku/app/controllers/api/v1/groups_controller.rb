module Api::V1
  class GroupsController < BaseController

=begin 
  def batch
  	return render json: {error: {message: "this operation requires topic_ids param separated between underscores. example: 1_12_312_4", code: 4001}}, status: :not_acceptable if params[:topic_ids].blank?
  	topics = Topic.where(id: params[:topic_ids].split('_'))
  	render json: V1::TopicPresenter.array(topics)
  end
=end

    def create
      group = @current_user.groups.create!(params[:group])
      group.entity_user_join(group.entity_user)
      render json: GroupPresenter.new(group)
    end

    def show
      render json: GroupPresenter.new(group)
    end

    def posts
    	posts = group.posts(params.slice(:limit, :before))
    	render json: PostPresenter.array(posts).to_json
    end

    def posts_with_family
      posts = group.posts.as_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).with_family
    end

    def join
      eu = EntityUser.eu(group.entity_id, @current_user.id)
      gu = group.entity_user_join(eu)
      render json: gu.persisted?
    end

    def leave
      eu = EntityUser.eu(group.entity_id, @current_user.id)
      gu = group.entity_user_leave(eu)
      render json: !gu.persisted?
    end

    private

    def group
    	@group ||= Group.find(params[:id])
    end
  end
end