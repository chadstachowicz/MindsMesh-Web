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
  end
  describe "custom class methods" do
    describe "notify_owner" do
      it "works" do
        reply = Fabricate(:reply)
        post = reply.post
        Notification.notify_owner(post.user_id,
                                  post,
                                  Notification::ACTION_REPLIED,
                                  post.replies.count
                                  )
      end
    end

  end
end