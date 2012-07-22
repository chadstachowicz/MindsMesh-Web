require 'spec_helper'

describe Notification do
  describe "custom methods" do
    describe "action_as_verb" do
      it "should be a string" do
        n = Fabricate(:notification)
        n.action_as_verb.should be_a String
      end
    end
    describe "facebook_message" do
      it "should be a string" do
        n = Fabricate(:notification)
        n.facebook_message.should be_a String
      end
    end
  end

  describe "Facebook API" do

    before do
      @n = Fabricate(:notification)

    end

    describe "api_delete_fb_apprequest" do

      it "does not invoke without data" do
        User.any_instance.should_not_receive(:fb_api)
        @n.fb_apprequest_id = nil
        @n.api_delete_fb_apprequest
      end

      it "invokes with data" do

        Koala::Facebook::API.any_instance.stub(delete_object: 'stub')
        Koala::Facebook::API.any_instance.should_receive(:delete_object)
                                         .with('111111')
        @n.fb_apprequest_id = '111111'
        @n.api_delete_fb_apprequest
        @n.fb_apprequest_id.should be_nil
      end
      
    end

    describe "api_post_fb_apprequest" do

      it "invokes and stores returned data" do
        Koala::Facebook::API.any_instance.stub(put_connections: {'request' => 'aaa', 'to' => ['bb']})
        Koala::Facebook::API.any_instance.should_receive(:put_connections)
                                         .with("me", "apprequests", kind_of(Hash))
        ->{
          @n.api_post_fb_apprequest
        }.should change(@n, :fb_apprequest_id).to('aaa_bb')
      end
      
    end
    
    describe "mark_as_read!" do
      it "works" do
        @n.stub(:api_delete_fb_apprequest)
        @n.should_receive(:api_delete_fb_apprequest).once
        @n.should_receive(:save!).once

        @n.mark_as_read!
        @n.b_read.should be_true
      end
    end

    describe "notify_on_facebook!" do
      it "invokes api methods and saves" do
        @n.stub(:api_delete_fb_apprequest)
        @n.stub(:api_post_fb_apprequest)
        @n.should_receive(:api_delete_fb_apprequest).once
        @n.should_receive(:api_post_fb_apprequest).once
        @n.should_receive(:save!).once
        
        @n.notify_on_facebook!
      end
    end

  end


  describe "custom class methods" do
=begin
    describe "notify_owner" do
      it "works" do
        reply = Fabricate(:reply)
        post = reply.post
        -> {
          Notification.notify_owner(
            post,
            Notification::ACTION_REPLIED,
            post.replies.count
          )
        }.should change(Notification, :count)
      end
    end
=end
    describe "notify_user!" do
      it "works" do
        tu = Fabricate(:topic_user)

        Notification.any_instance.stub(:notify_on_facebook!)
        Notification.any_instance.should_receive(:notify_on_facebook!).once

        Notification.notify_user!(tu.user, tu.topic, Notification::ACTION_REPLIED, 1000)
        
        n=Notification.last
        n.actors_count.should ==1000
        n.b_read.should be_false
      end
    end
    describe "notify_users_involved_in_post" do
      it "works" do
        Notification.any_instance.stub(:notify_on_facebook!)
        Notification.any_instance.should_receive(:notify_on_facebook!)
        
        reply = Fabricate(:reply)
        -> {
          Notification.notify_users_involved_in_post(
            reply.post_id,
            Notification::ACTION_REPLIED,
            reply.user_id
          )
        }.should change(Notification, :count)
      end
    end
    describe "notify_users_in_topic" do
      it "works" do
        Notification.any_instance.stub(:notify_on_facebook!)
        Notification.any_instance.should_receive(:notify_on_facebook!)
        topic_user = Fabricate(:topic_user)
        Fabricate(:topic_user, topic: topic_user.topic)

        -> {
          Notification.notify_users_in_topic(
            topic_user.topic_id,
            Notification::ACTION_POSTED,
            topic_user.user_id
          )
        }.should change(Notification, :count)
      end
    end
  end
end