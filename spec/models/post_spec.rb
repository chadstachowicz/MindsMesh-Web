require 'spec_helper'

describe Post do

  def valid_attributes
    { text: Faker::Lorem.sentence }
  end

  describe "associations" do
    describe "understands" do
      {user: User, topic: Topic, replies: Array, likes: Array}.each do |assoc, clazz|
        it assoc do
          post = Fabricate(:post)
          post.should be_valid
          post.should respond_to(assoc)
          post.send(assoc).should be_a(clazz)
        end
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
    pending "test these with real data"
    it "before" do
      Post.before(nil).should be_a(ActiveRecord::Relation)
    end
    it "as_feed" do
      Post.as_feed.should be_a(ActiveRecord::Relation)
    end
  end

  describe "custom constructors" do

    it "create_with creates an associated post" do
      topic_user = Fabricate(:topic_user)
      -> {
        Post.create_with!(topic_user, valid_attributes)
      }.should change(Post, :count).by(1)
      -> {
        Post.create_with!(topic_user, valid_attributes)
      }.should change(topic_user.topic.posts, :count).by(1)
      -> {
        Post.create_with!(topic_user, valid_attributes)
      }.should change(topic_user.user.posts, :count).by(1)
    end

  end
end
