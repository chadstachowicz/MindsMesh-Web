require 'spec_helper'

describe User do

  describe "hooks" do
    describe "before_create" do
      it "change_access_token" do
        User.any_instance.should_receive(:change_access_token).once
        Fabricate(:user)
      end
    end
    describe "after_create" do
      it "joins self-joining entities" do
        entity1 = Fabricate(:entity, self_joining: false)
        entity2 = Fabricate(:entity, self_joining: true)
        user=Fabricate(:user)
        user.entity_users.map(&:entity).should == [entity2]
      end
    end
  end

  describe "associations" do
    describe "understands has_many" do
      {logins: Login, entity_user_requests: EntityUserRequest, entity_users: EntityUser, entities: Entity, topic_users: TopicUser, topics: Topic, posts: Post, replies: Reply, likes: Like, notifications: Notification}.each do |assoc, clazz|
        it assoc do
          record = Fabricate.build(:user) { send(assoc, count: 3) }
          record.should respond_to(assoc)
          record.send(assoc).should be_a Array
          record.send(assoc).sample.should be_a clazz
        end
      end
    end
  end

  describe "role_i" do
    before do
      @user = Fabricate.build(:user)
    end

    User::ROLES.keys.each do |role|
      it "get/set/? #{role}" do
        @user.send("#{role}?").should_not be_true
        @user.role = role
        @user.role.should ==role
        @user.send("#{role}?").should be_true
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
      describe "change_access_token" do
        it "works" do
          user = Fabricate.build(:user)
          -> {
            user.change_access_token
          }.should change(user, :access_token)
        end
      end
    end

    describe "external api" do
      describe "fb_api" do
        it "should not work for expired token" do
          Fabricate.build(:user, fb_expires_at: DateTime.yesterday).fb_api.should == :expired
        end
        it "should bring api object for unexpired token" do
          Fabricate.build(:user, fb_expires_at: DateTime.tomorrow).fb_api.should be_a Koala::Facebook::API
        end
      end
    end

    describe "relational" do
      describe "posts_feed" do
        it "should return an empty array if you don't have topics" do
          user = Fabricate.build(:user)
          user.posts_feed.should == []
        end
        it "should return a query for posts if you have topics" do
          user = Fabricate(:topic_user).user
          user.posts_feed.should be_instance_of(ActiveRecord::Relation)
        end
      end
      describe "search_topics" do
        it "works" do
          eu     = Fabricate(:entity_user)
          user   = eu.user
          entity = eu.entity

          john   = Fabricate(:topic, entity: entity, name: "John")
          jonas  = Fabricate(:topic, entity: entity, name: "Jonas")
          jeremy = Fabricate(:topic, entity: entity, name: "Jeremy")

          user.search_topics('Jo').map(&:name).sort.should == [john, jonas].map(&:name).sort
          user.search_topics('J').map(&:name).sort.should == [john, jonas, jeremy].map(&:name).sort
          user.search_topics('').map(&:name).sort.should == [john, jonas, jeremy].map(&:name).sort
          user.search_topics('mary').map(&:name).sort.should == [].map(&:name).sort
        end
      end
    end

  end

end
