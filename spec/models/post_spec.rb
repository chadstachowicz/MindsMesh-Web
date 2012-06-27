require 'spec_helper'

describe Post do

  def valid_attributes
    { text: Faker::Lorem.sentence }
  end

  describe "associations" do
    describe "understands belongs_to" do
      {user: User, topic: Topic}.each do |assoc, clazz|
        it assoc do
          record = Fabricate(:post)
          record.should be_valid
          record.should respond_to(assoc)
          record.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "understands has_many" do
      before do
        @record_class = :post
      end
      {replies: Reply, likes: Like}.each do |assoc, clazz|
        it assoc do
          record = Fabricate.build(@record_class) { send(assoc, count: 3) }
          record.should respond_to(assoc)
          record.send(assoc).should be_a Array
          record.send(assoc).sample.should be_a clazz
        end
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
