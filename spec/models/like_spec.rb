require 'spec_helper'

describe Like do
  describe "associations" do
    describe "understands belongs_to" do
      {user: User, likable: ActiveRecord::Base}.each do |assoc, clazz|
        it assoc do
          record = Fabricate(:like)
          record.should be_valid
          record.should respond_to(assoc)
          record.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "understands belongs_to polymorphic likable" do
      %w(post reply).each do |likable_type|
        it "#{likable_type} is likable" do
          likable = Fabricate(likable_type)
          -> {
            Fabricate(:like, likable: likable)
          }.should change(likable.likes, :count).by(1)
        end
      end
    end
  end

  describe "field validations" do
    it "user_id is unique per likable" do
      user = Fabricate(:user)
      post = Fabricate(:post)

      -> {
        Fabricate(:like, user: user, likable: post)
      }.should change(post.likes, :count).by(1)
      
      -> {
        Fabricate(:like, user: user, likable: post)
      }.should raise_error(ActiveRecord::RecordInvalid)

      like = Fabricate.build(:like, user: user, likable: post)
      like.should_not be_valid
      like.errors[:user_id].should_not be_empty
    end
  end
end
