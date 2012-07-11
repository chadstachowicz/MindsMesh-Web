require 'spec_helper'

describe Entity do

  describe "custom methods" do
    
    pending "make a user_leave! method, this would require unexisting UI logic"

    describe "user_join!" do
      before do
        @entity = Fabricate(:entity)
        @user=Fabricate(:user)
      end
      it "creates an entity_user" do
        ->{
          ->{
            @entity.user_join!(@user)
          }.should change(@user.entity_users, :count).by(1)
        }.should change(@entity.entity_users, :count).by(1)
      end
      it "raises an exception if called twice" do
        @entity.user_join!(@user)
        ->{
          @entity.user_join!(@user)
        }.should raise_error(ActiveRecord::RecordInvalid)
       end
      it "should change user's role" do
        -> {
          @entity.user_join!(@user)
        }.should change(@user, :roles).from(['user']).to(['client', 'user'])
      end
    end
  end

  describe "associations" do
    describe "understands has_many" do
      before do
        @record_class = :entity
      end
      {entity_user_requests: EntityUserRequest, entity_users: EntityUser, topics: Topic}.each do |assoc, clazz|
        it assoc do
          record = Fabricate.build(@record_class) { send(assoc, count: 3) }
          record.should respond_to(assoc)
          record.send(assoc).should be_a Array
          record.send(assoc).sample.should be_a clazz
        end
      end
    end
  end

  describe "hooks" do
    it "slugfies" do
      e = Fabricate.build(:entity)
      -> {
        e.valid?
      }.should change(e, :slug)
    end
  end

end
