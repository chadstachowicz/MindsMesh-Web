require 'spec_helper'

describe Login do
  pending "write more tests: #{__FILE__}"

  describe "auth!" do
    it "raises an exception with invalid params" do
      lambda {
        Login.auth!(nil)
      }.should raise_error(RuntimeError, 'invalid facebook login')
    end
  end

end
