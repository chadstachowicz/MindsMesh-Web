require 'spec_helper'

describe SectionUser do
  describe "role" do

    it "should be a string" do
      section_user = Fabricate.build(:section_user)
      section_user.role_s.should be_instance_of(String)
    end

    it "should be one of the listed roles" do
      # TODO: review these
      SectionUser::ROLES.should include(Fabricate.build(:section_user).role)
      SectionUser::ROLES.should include(Fabricate.build(:section_user, role: "moderator").role)
      SectionUser::ROLES.should include(Fabricate.build(:section_user, role: "teacher").role)
    end
  end
end
