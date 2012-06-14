require 'spec_helper'

describe Login do

  describe "auth!" do
    it "raises an exception with invalid params" do
      -> { Login.auth!(nil) }.should raise_error(RuntimeError, 'invalid facebook login')
    end
  end

end
