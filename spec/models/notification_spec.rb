require 'spec_helper'

describe Notification do
  describe "custom methods" do
  	describe "mark_as_read" do
  	  it "marks as read" do
  	  	n = Fabricate(:notification)
  	  	-> {
  	  	  n.mark_as_read
  	  	}.should change(n, :b_read).from(false).to(true)
  	  end
  	end
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
    describe "notify_on_facebook!" do
      it "stores a fb_apprequest_id" do
        Fabricate(:notification)
        n = Notification.last
        ->{
          n.notify_on_facebook!
        }.should change(n, :fb_apprequest_id)
        n.fb_apprequest_id.should_not be_blank
      end
    end
    describe "set_fb_apprequest_id" do
      it "works" do
        n=Notification.new
        ->{
          n.set_fb_apprequest_id("request"=>"999", "to"=>["111"])
        }.should change(n, :fb_apprequest_id).to("999_111")
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
    describe "notify_users_involved_in_post" do
      it "works" do
        post = Fabricate(:post)
        -> {
          Notification.notify_users_involved_in_post(
            post.id,
            Notification::ACTION_REPLIED
          )
        }.should change(Notification, :count)
      end
    end
    describe "notify_users_in_topic" do
      it "works" do
        topic = Fabricate(:topic_user).topic
        -> {
          Notification.notify_users_in_topic(
            topic.id,
            Notification::ACTION_POSTED
          )
        }.should change(Notification, :count)
      end
    end
  end
end