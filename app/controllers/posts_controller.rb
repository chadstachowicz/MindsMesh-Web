class PostsController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /posts
  def index
    @posts = Post.all
    respond_with(@posts)
  end

  # GET /posts/1
  def show
    respond_with(@post)
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

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_with(@post)
  end
end
