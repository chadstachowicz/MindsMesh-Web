require 'spec_helper'

describe EntityUser do
  describe "hooks" do
    describe "after_create" do
      it "user joins self-joining topics" do
        entity = Fabricate(:entity)
        user   = Fabricate(:user)

        topic1 = Fabricate(:topic, entity: entity, self_joining: false)
        topic2 = Fabricate(:topic, entity: entity, self_joining: true)

        entity_user = Fabricate(:entity_user, user: user, entity: entity)
        
        user.topic_users.map(&:topic).should == [topic2]
      end
    end
  end
  describe "field validations" do
    it "user_id is unique per entity" do
      record_name = :entity_user
      fields = {entity: Fabricate(:entity), user: Fabricate(:user)}
      
      -> {
        Fabricate(record_name, fields)
      }.should change(EntityUser, :count).by(1)
      
      -> {
        Fabricate(record_name, fields)
      }.should raise_error(ActiveRecord::RecordInvalid)

      record = Fabricate.build(record_name, fields)
      record.should_not be_valid
      record.errors[:user_id].should_not be_empty
    end
  end
end
