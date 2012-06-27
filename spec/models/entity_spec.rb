require 'spec_helper'

describe Entity do

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

  describe "simple field validations" do
    it "requires name" do
      entity = Fabricate.build(:entity, name: nil)
      entity.should_not be_valid
      entity.errors[:name].should_not be_empty
    end
  end

end
