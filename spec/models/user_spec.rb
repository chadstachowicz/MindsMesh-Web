require 'spec_helper'

describe User do

  describe "roles_mask" do
    before do
      @user = Fabricate.build(:user)
    end

    describe "roles getter" do

      it "should be an array" do
        @user.roles.should be_instance_of(Array)
        @user.roles.should be ==['user']
        @user.roles.should_not be_empty
      end

      it "should save correctly" do
        @user.roles_mask.should be_zero
        @user.roles = [:client]
        @user.roles_mask.should == 1
        @user.roles = [:client, :master]
        @user.roles_mask.should == 17
        @user.roles = [:master]
        @user.roles_mask.should == 16
      end
    end

    describe "roles= setter" do
      
      it "should raise for unkown type" do
        -> {
          roles = ['admin', 'lalala']
          @user.roles = roles
        }.should raise_error(RuntimeError)
      end

      it "should set correctly" do
        @user.roles = User::ROLES_MAP.keys
        @user.roles.should == User::ROLES_MAP.keys.map(&:to_s)
        @user.roles_mask.should == 31
      end

    end

    describe "{role}?" do

      it "should work" do
        @user.should_not be_client
        @user.should_not be_moderator
        @user.should_not be_manager
        @user.should_not be_admin
        @user.should_not be_master
      end

      it "should always include in lesser roles" do
        @user.roles += ['moderator']
        @user.should     be_client
        @user.should     be_moderator
        @user.should_not be_manager
        @user.should_not be_admin
        @user.should_not be_master

        @user.roles += ['master']
        @user.should     be_client
        @user.should     be_moderator
        @user.should     be_manager
        @user.should     be_admin
        @user.should     be_master
      end
    end
  end

  describe "custom methods" do

    describe "basic" do
      describe "photo_url" do
        it "brings string" do
          User.new.photo_url.should be_a String
        end
      end
    end

    describe "external api" do
      describe "fb_api" do
        it "should not work for expired token" do
          Fabricate.build(:user, fb_expires_at: DateTime.yesterday).fb_api.should be_false
        end
        it "should bring api object for unexpired token" do
          Fabricate.build(:user, fb_expires_at: DateTime.tomorrow).fb_api.should be_a Koala::Facebook::API
        end
      end
    end

    describe "relational" do
      describe "posts_feed" do
        it "should return a query for posts" do
          user = Fabricate.build(:user)
          user.posts_feed.should be_instance_of(ActiveRecord::Relation)
        end
      end
    end

  end

end
