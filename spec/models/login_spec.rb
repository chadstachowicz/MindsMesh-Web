require 'spec_helper'

describe Login do

  describe "auth!" do
    it "raises an exception with invalid params" do
      -> { Login.auth!(nil) }.should raise_error(RuntimeError, 'invalid facebook login')
    end
  end
  describe "auth" do
  	it "brings infomative symbol if nil" do
  	  Login.new.auth.should == :auth_nil
  	end
  	it "bring a hash" do
  	  Login.new(auth_s: '{}').auth.should be_a Hash
  	end
  end

end
