require 'spec_helper'

describe TopicUser do
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
end
