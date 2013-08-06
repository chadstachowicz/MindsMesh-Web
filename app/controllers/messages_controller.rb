class MessagesController < ApplicationController
  respond_to :html#, :json, :xml
  load_and_authorize_resource


  # GET /messages
  def index
    
  end
    
  def new

  end

  # GET /messages/1
  def show
    @user = current_user
    @messages = @user.messages
  end
    
    
  # # GET /messages/1/more_posts.js
  # def more_posts
  # end

  # GET /messages/1/edit
  def edit

  end

  # PUT /messages/1
  def update
    #@user.update_attributes(params[:user])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User successfully updated."
    end
    respond_with(@user, location: @user)
  end

  # DELETE /messages/1
  def destroy
    @user.destroy
    respond_with(@user)
  end
end
