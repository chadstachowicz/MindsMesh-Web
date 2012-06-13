class UsersController < ApplicationController
  before_filter :must_user

  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /users
  def index
    @users = User.all
    respond_with(@users)
  end

  # GET /users/1
  def show
    respond_with(@user)
  end

  # GET /users/1/edit
  def edit
    respond_with(@user)
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
