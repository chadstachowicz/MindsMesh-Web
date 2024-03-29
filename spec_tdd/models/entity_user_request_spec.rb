require 'spec_helper'

describe EntityUserRequest do

  describe "field validations" do
    it "user_id is unique per entity" do
      record_name = :entity_user_request
      fields = {entity: Fabricate(:entity), user: Fabricate(:user)}
      

      -> {
        Fabricate(record_name, fields)
      }.should change(EntityUserRequest, :count).by(1)
      
      -> {
        Fabricate(record_name, fields)
      }.should raise_error(ActiveRecord::RecordInvalid)

      record = Fabricate.build(record_name, fields)
      record.should_not be_valid
      record.errors[:user_id].should_not be_empty
    end
    it "email is unique per entity" do
      record_name = :entity_user_request
      fields = {entity: Fabricate(:entity), email: "lalala@uncc.edu"}
      

      -> {
        Fabricate(record_name, fields)
      }.should change(EntityUserRequest, :count).by(1)
      
      -> {
        Fabricate(record_name, fields)
      }.should raise_error(ActiveRecord::RecordInvalid)

      record = Fabricate.build(record_name, fields)
      record.should_not be_valid
      record.errors[:email].should_not be_empty
    end
  end

  describe "email validation" do
    
    it "allow valid @uncc.edu" do
      eur = Fabricate.build(:entity_user_request, email: "lalala@uncc.edu")
      eur.should be_valid
    end
    
    it "not allow invalid @uncc.edu" do
      eur = Fabricate.build(:entity_user_request, email: "lalala@gmail.com")
      eur.should_not be_valid
    end

  end

  describe "callbacks" do
    describe "before save" do
      it "email is always downcase" do
        v = "LELELE@UNCC.EDU"
        eur = Fabricate.build(:entity_user_request, email: v)
        -> {
          eur.save
        }.should change(eur, :email).from(v).to('lelele@uncc.edu')
      end
    end
  end

  describe "custom methods" do
    it "generate_and_mail_new_token" do
      eur = Fabricate.build(:entity_user_request)
      -> {
        eur.generate_and_mail_new_token
        }.should change(eur, :confirmation_token)
    end
    describe "confirmed?" do
      it "returns true or false" do
        eur = Fabricate.build(:entity_user_request)
        [true, false].should include(eur.confirmed?)
      end
    end
    describe "confirm" do
      it "should not remove itself" do
        @eur = Fabricate(:entity_user_request)
        -> {
          -> {
            @eur.confirm.should be_a(EntityUser) #return entity_user
          }.should_not change(EntityUserRequest, :count)
        }.should change(@eur, :confirmed_at)
        @eur.confirm.should be_false #return false if already confirmed
      end
=begin
      it "should invoke eu.joins_self_joinings_topics" do
        EntityUser.any_instance.should_receive(:joins_self_joinings_topics)
        @eur.confirm
      end
=end
    end
  end
end
