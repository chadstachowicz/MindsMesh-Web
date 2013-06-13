class MessagesController < ApplicationController
  respond_to :html#, :json, :xml
  load_and_authorize_resource


  # GET /users
  def index

  end
    
  def new

  end

  # GET /users/1
  def show

  end
    
    
  # GET /users/1/more_posts.js
  def more_posts

  end

  # GET /users/1/edit
  def edit

  end

  # PUT /users/1
  def update
    #@user.update_attributes(params[:user])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User successfully updated."
    end
    respond_with(@user, location: @user)
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_with(@user)
  end
end
