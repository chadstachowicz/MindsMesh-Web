require 'spec_helper'

describe SchoolUserRequest do
  describe "email validation" do
    
    it "allow valid @uncc.edu" do
      suq = Fabricate.build(:school_user_request, email: "lalala@uncc.edu")
      suq.valid?.should be_true
    end
    
    it "not allow invalid @uncc.edu" do
      suq = Fabricate.build(:school_user_request, email: "lalala@gmail.com")
      suq.valid?.should be_false
    end

  end
end
