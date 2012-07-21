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

  describe "with_children" do

    it "with valid params" do
      topic_user = Fabricate(:topic_user)
      user  = topic_user.user
      topic = topic_user.topic
      entity = topic.entity
      Fabricate(:entity_user, entity: entity, user: user)

      get :with_children, {id: user.to_param}
      response.status.should == 200
      response.body.should include 'topic_users'
      response.body.should include topic.name
      response.body.should include 'entity_users'
      response.body.should include entity.name
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
