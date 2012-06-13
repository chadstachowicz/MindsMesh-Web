require 'spec_helper'

describe User do

  describe "roles" do

    before(:each) do
      @user = Fabricate(:user, roles_s: 'student master')
    end

    it "should be an array" do
      @user.roles.should be_instance_of(Array)
    end

    it "should match given role methods properly" do
      @user.user?.should      be_false
      @user.student?.should   be_true
      @user.moderator?.should be_false
      @user.teacher?.should   be_false
      @user.admin?.should     be_false
      @user.master?.should    be_true
    end
  end

end
