require 'spec_helper'

describe User do

  describe "roles" do

    before(:each) do
      @user = Fabricate.build(:user, roles_s: 'client master')
    end

    it "should be an array" do
      @user.roles.should be_instance_of(Array)
    end

    it "should match given role methods properly" do
      @user.guest?.should     be_false
      @user.user?.should      be_false
      @user.client?.should    be_true
      @user.moderator?.should be_false
      @user.manager?.should   be_false
      @user.admin?.should     be_false
      @user.master?.should    be_true
    end
  end

  describe "role?" do
    
    before(:each) do
      @user = Fabricate.build(:user, roles_s: 'manager admin')
    end

    it "should raise for unkown type" do
      -> { @user.role?(:cool) }.should raise_error(RuntimeError)
    end

    it "should return false for user" do
      @user.role?(:user).should           be_false
      @user.role?(:user, :manager).should be_true
    end

    it "should return false for empty" do
      @user.role?().should be_false
    end

    it "should return false for guest" do
      @user.role?(:guest).should           be_false
      @user.role?(:guest, :client).should  be_false
      @user.role?(:guest, :manager).should be_true
    end

    it "should check if at least one role match" do
      @user.role?(:admin, :master).should be_true
      @user.role?(:admin).should          be_true
      @user.role?(:master).should         be_false
      @user.role?(:client).should         be_false
    end

  end

  describe "roles=" do
    
    it "should raise for unkown type" do
      user = Fabricate.build(:user)
      user.roles.should be_empty
      roles = ['admin', 'manager']
      user.roles = roles
      user.roles.should == roles
    end

  end

  describe "posts_feed" do
    
    it "should return a query for posts" do
      user = Fabricate.build(:user)
      user.posts_feed.should be_instance_of(ActiveRecord::Relation)
    end

  end

end
