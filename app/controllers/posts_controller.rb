class PostsController < ApplicationController
  respond_to :html#, :json, :xml
  respond_to :js, only: [:destroy]

  load_and_authorize_resource except: [:replies, :like]
  load_resource only: [:replies, :like]

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
  def replies
    #if you are authorized to read it, you can also reply, always
    authorize! :read, @post
    reply = @post.replies.build(params[:reply])
    reply.user = current_user
    reply.save!
    redirect_to @post
  end

  # PUT /posts/1/like
  def like
    #doesn't do anything if user already liked it
    Like.create user: current_user, likable: @post
    render text: @post.likes.size
  end

  # GET /posts/1/edit
  def edit
    respond_with(@post)
  end

  # PUT /posts/1
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post successfully updated."
    end
    respond_with(@post, location: @post)
  end

  # DELETE /posts/1.js
  def destroy
    @post.destroy
    respond_with(@post)
  end
end
