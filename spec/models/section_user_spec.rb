require 'spec_helper'

describe SectionUser do
  describe "role" do

    it "should be a string" do
      section_user = Fabricate.build(:section_user)
      section_user.role.should be_instance_of(String)
    end

    it "should be one of the listed roles" do
      section_users = [
        Fabricate.build(:section_user),
        Fabricate.build(:section_user, b_teacher: true),
        Fabricate.build(:section_user, b_moderator: true)
      ]
      section_users.each do |section_user|
        SectionUser::ROLES.should include(section_user.role)
      end
    end
  end
end
