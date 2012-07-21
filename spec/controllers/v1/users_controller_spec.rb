require 'spec_helper'

describe V1::UsersController do

  describe "show" do

    it "with valid params" do
      user = Fabricate(:user)
      V1::UserPresenter.should_receive(:new).with(user)
      get :show, {id: user.to_param}
      response.status.should == 200
    end
    
  end

  describe "posts" do

    it "with valid params" do
      user = Fabricate(:user)
      V1::PostPresenter.should_receive(:array).with([])
      get :posts, {id: user.to_param}
      response.status.should == 200
    end
    
  end

  describe "batch" do
    
    it "with invalid params" do
      get :batch, {}
      response.status.should == 406
    end
    
    it "with valid params" do
      user = Fabricate(:user)
      V1::UserPresenter.should_receive(:array).with([user])
      get :batch, {user_ids: [user.id].join('_')}
      response.status.should == 200
    end

  end

end
