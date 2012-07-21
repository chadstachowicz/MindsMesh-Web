require 'spec_helper'

describe V1::TopicsController do

  describe "show" do

    it "with valid params" do
      topic = Fabricate(:topic)
      V1::TopicPresenter.should_receive(:new).with(topic)
      get :show, {id: topic.to_param}
      response.status.should == 200
    end
    
  end

  describe "posts" do

    it "with valid params" do
      topic = Fabricate(:topic)
      V1::PostPresenter.should_receive(:array).with([])
      get :posts, {id: topic.to_param}
      response.status.should == 200
    end
    
  end
  
=begin
  describe "batch" do
    
    it "with invalid params" do
      get :batch, {}
      response.status.should == 406
    end
    
    it "with valid params" do
      topic = Fabricate(:topic)
      V1::TopicPresenter.should_receive(:array).with([topic])
      get :batch, {topic_ids: [topic.id].join('_')}
      response.status.should == 200
    end

  end
=end

end
