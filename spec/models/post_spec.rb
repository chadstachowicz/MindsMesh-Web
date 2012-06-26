require 'spec_helper'

describe Post do

  describe "associations" do
    describe "understands" do
      {user: User, topic: Topic, topic_user: TopicUser, replies: Array, likes: Array}.each do |assoc, clazz|
        it assoc do
          post = Fabricate(:post)
          post.should respond_to(assoc)
          post.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "validating topic and user" do
      it "valid from topic_user" do
        post = Fabricate.build(:post, topic: nil, user: nil, topic_user: Fabricate(:topic_user))
        post.should be_valid
      end
      it "valid from topic && user" do
        post = Fabricate.build(:post, topic: Fabricate(:topic), user: Fabricate(:user), topic_user: nil)
        post.should be_valid
      end
      it "invalid from only topic" do
        post = Fabricate.build(:post, topic: Fabricate(:topic), user: nil, topic_user: nil)
        post.should_not be_valid
        post.errors[:user].should_not be_empty
      end
      it "invalid from only topic" do
        post = Fabricate.build(:post, topic: nil, user: Fabricate(:user), topic_user: nil)
        post.should_not be_valid
        post.errors[:topic].should_not be_empty
      end
    end
    describe "validating has_many" do
      it "replies" do
        post = Fabricate.build(:post) { replies count: 3 }
        post.replies.size.should ==3
        post.replies.sample.should be_a Reply
      end
      it "likes" do
        post = Fabricate.build(:post) { likes count: 3 }
        post.likes.size.should ==3
        post.likes.sample.should be_a Like
      end
    end
    it "doubt" do
      "should I validate counters with size?".should be_true
    end
  end

  describe "simple field validations" do
    it "requires text" do
      post = Fabricate.build(:post, text: nil)
      post.should_not be_valid
      post.errors[:text].should_not be_empty
    end
    it "requires text to have at least 10 chars" do
      post = Fabricate.build(:post, text: '123456789')
      post.should_not be_valid
      post.errors[:text].should_not be_empty
      post.text = '1234567890'
      post.valid?
      post.errors[:text].should be_empty
    end
  end

  describe "custom scopes" do
    it "before" do
      Post.before(nil).should be_a(ActiveRecord::Relation)
      "test these decently".should be_true
    end
    it "as_feed" do
      Post.as_feed.should be_a(ActiveRecord::Relation)
    end
  end
end
