require 'spec_helper'

describe TopicUser do
  describe "custom validations" do
    it "both_in_entity" do
      user = Fabricate(:user)
      topic = Fabricate(:topic)
      record = Fabricate.build(:topic_user, user: user, topic: topic)

      record.should_not be_valid
      record.errors[:user].should_not be_empty

      Fabricate(:entity_user, entity: topic.entity, user: user)

      record.should be_valid
      record.errors[:user].should be_empty
    end
  end
=begin
  describe "role" do

    it "should be a string" do
      topic_user = Fabricate.build(:topic_user)
      topic_user.role_s.should be_instance_of(String)
    end

    it "should be one of the listed roles" do
      # TODO: review these
      TopicUser::ROLES.should include(Fabricate.build(:topic_user).role)
      TopicUser::ROLES.should include(Fabricate.build(:topic_user, role: "moderator").role)
      TopicUser::ROLES.should include(Fabricate.build(:topic_user, role: "teacher").role)
    end
  end
=end
end
