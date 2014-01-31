module Api::V1
  class UsersController < BaseController
=begin
  def batch
  	return render json: {error: {message: "this operation requires user_ids param separated between underscores. example: 1_12_312_4", code: 2001}}, status: :not_acceptable if params[:user_ids].blank?
  	users = User.where(id: params[:user_ids].split('_'))
  	render json: V1::UserPresenter.array(users)
  end
=end
    
    skip_before_filter :authenticate, only: :create

    def show
      render json: UserPresenter.new(user)
    end

    def with_children
      render json: UserPresenter.new(user).with_children
    end

    def posts
    	posts = user.posts(params.slice(:limit, :before))
    	render json: PostPresenter.array(posts)
    end

    def posts_with_parents
      posts = user.posts.as_feed(params.slice(:limit, :before))
      render json: PostPresenter.array(posts).map(&:with_parents)
    end
      
    def create
        user2 = User.new(:name => params[:name],
                            :email => params[:email],
                            :password => params[:password]
                            )
        user2.save!
        sign_in user2
        entity = Entity.find_by_email_domain(params[:email])
        return render text: entity if entity.is_a? String
        eur = user2.entity_user_requests.where(entity_id: entity.id, email: params[:email]).first_or_initialize
        eur.generate_and_mail_new_token
        text = eur.save
        return render json: UserPresenter.new(user2).as_me
        
    end


    private

    def user
    	@user ||= User.find(params[:id])
    end
      

  end
end