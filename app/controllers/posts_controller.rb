class PostsController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource except: [:like]
  load_resource only: [:like, :update]

  # GET /posts
  def index
    @posts = Post.all
    respond_with(@posts)
  end

  # GET /posts/1
  def show
    respond_with(@post)
  end

  # POST /posts/1/replies
  def create_reply
    reply = @post.replies.build(params[:reply])
    reply.user = current_user
    if reply.save
      render reply
    else
      render status: 422, text: reply.errors.full_messages.to_sentence
    end
  end
    
   # POST Encode_Video
    def encode_video
        response = Zencoder::Job.create({
            :input => params[:fileinput],
            :output => {
            :width => "480",
            :url => params[:fileoutput],
                            }
            })
        respond_with("success")
  end

  # POST /posts/1/like
  def like
    #doesn't do anything if user already liked it
    Like.create user: current_user, likable: @post
    render text: @post.reload.likes.size
  end

  # POST /posts/1/unlike
  def unlike
    #doesn't do anything if user already liked it
    @post.likes.where(user_id: current_user.id).first.try(:destroy)
    render text: @post.reload.likes.size
  end

  # PUT /posts/1
  def update
    if @post.update_attributes(params[:post])
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1.js
  def destroy
    @post.destroy
    render nothing: true
  end
end
