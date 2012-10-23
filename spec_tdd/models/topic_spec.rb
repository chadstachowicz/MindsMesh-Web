require 'spec_helper'

describe Topic do


  describe "associations" do
    describe "understands belongs_to" do
      {entity: Entity, user: User}.each do |assoc, clazz|
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

  it "calls compose_name_and_slugify" do
    t = Fabricate.build(:topic)
    t.should_receive(:compose_name_and_slugify)
    t.valid?
  end

  it "slugifies" do
    t = Fabricate.build(:topic)
    t.slug.should be_nil
    t.name.should be_nil
    t.should be_valid
  end
  
  it "entity_user_join and entity_user_leave" do
    t = Fabricate(:topic)
    eu = Fabricate(:entity_user)
    tu = nil

    ->{
      ->{
        tu = t.entity_user_join(eu)
        tu.should be_kind_of(TopicUser)
        tu.should be_persisted
      }.should change(eu.user.topic_users, :count).by(1)
    }.should change(t.topic_users, :count).by(1)

    ->{
      ->{
        tu2 = tu.topic.entity_user_leave(eu)
        tu2.should be_kind_of(TopicUser)
        tu2.should_not be_persisted
      }.should change(tu.user.topic_users, :count).by(-1)
    }.should change(tu.topic.topic_users, :count).by(-1)
  end
  
end
