require 'spec_helper'

describe EntityUser do
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
