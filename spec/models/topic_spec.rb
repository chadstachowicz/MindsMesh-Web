require 'spec_helper'

describe Topic do


  describe "associations" do
    describe "understands belongs_to" do
      {entity: Entity}.each do |assoc, clazz|
        it assoc do
          record = Fabricate(:topic)
          record.should be_valid
          record.should respond_to(assoc)
          record.send(assoc).should be_a(clazz)
        end
      end
    end
    describe "understands has_many" do
      before do
        @record_class = :topic
      end
      {topic_users: TopicUser, posts: Post, users: User}.each do |assoc, clazz|
        it assoc do
          record = Fabricate.build(@record_class) { send(assoc, count: 3) }
          record.should respond_to(assoc)
          record.send(assoc).should be_a Array
          record.send(assoc).sample.should be_a clazz
        end
      end
    end
  end

  it "slugfies" do
  	t = Fabricate.build(:topic)
  	-> {
  	  t.valid?
  	}.should change(t, :slug)
  end

  pending "remove duplicated logic from topics#join"

  it "user_join" do
  	u = Fabricate(:user)
  	t = Fabricate(:topic)

    ->{
      ->{
  		t.user_join(u)
      }.should change(u.topic_users, :count).by(1)
    }.should change(t.topic_users, :count).by(1)
  end
end
