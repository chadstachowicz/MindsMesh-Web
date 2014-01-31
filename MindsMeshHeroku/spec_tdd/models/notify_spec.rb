require 'spec_helper'

describe Notify do

  before do
    Koala::Facebook::API.any_instance.stub(delete_object: 'stub')
    Koala::Facebook::API.any_instance.stub(put_connections: 'stub')
  end

  describe "field validations" do
    it "requires target" do
      notify = Notify.new
      notify.should_not be_valid
      notify.errors[:target].should_not be_empty
    end
  end
  describe "custom class methods" do
  	describe "run_all" do
      it "works with empty lists" do
        ->{
          Notify.run_all %w(Like)
        }.should_not change(Notify, :count)
      end
      it "works with valid lists" do
        Fabricate(:notify_post)
        ->{
          Notify.run_all %w(Post)
        }.should change(Notify, :count)
      end
      it "works with invalid lists" do
        Fabricate(:notify_post)
        ->{
          Notify.run_all %w(Like)
        }.should_not change(Notify, :count)
      end
  	end
  end
  describe "custom methods" do
  	describe "run" do
  	  before do
        @notify = Fabricate(:notify_reply)
  	  end
      it "creates notifications" do
        ->{
          @notify.run
        }.should change(Notification, :count)
      end
      it "should behave the same if target has been destroyed" do
        @notify.target.destroy
        ->{
          @notify.run
        }.should_not raise_error
      end
      it "should delete itself" do
        @notify.run
        @notify.should_not be_persisted
      end
  	end
  	describe "run_post" do
  	  before do
        @notify = Fabricate(:notify_post)
  	  end
      it "gets forwarded by run" do
        @notify.stub(:run_post)
        @notify.should_receive(:run_post).once
        @notify.run
      end
      it "works" do
        Notification.stub(:notify_users_in_topic)
        Notification.should_receive(:notify_users_in_topic).with(@notify.target.topic_id, Notification::ACTION_POSTED, @notify.target.user_id).once
  	  	@notify.run_post
  	  end
  	end
  	describe "run_reply" do
  	  before do
        @notify = Fabricate(:notify_reply)
  	  	#Notification.stub :o OMG
  	  end
      it "gets forwarded by run" do
        @notify.stub(:run_reply)
        @notify.should_receive(:run_reply).once
        @notify.run
      end
  	  it "works" do
  	  	@notify.run_reply
  	  	#should create notifications according to each target_type
  	  	#will need more methods
  	  end
  	end
  	describe "run_like" do
  	  before do
        @notify = Fabricate(:notify_like)
  	  	#Notification.stub :o OMG
  	  end
      it "gets forwarded by run" do
        @notify.stub(:run_like)
        @notify.should_receive(:run_like).once
        @notify.run
      end
  	  it "works" do
  	  	@notify.run_like
  	  	#should create notifications according to each target_type
  	  	#will need more methods
  	  end
  	end
  end
end
