require 'spec_helper'

describe "Session" do

  describe "GET /auth/facebook" do
    it "with capybara: triggers callback and creates Bob Example" do
      Fabricate(:school)
      User.count.should == 0
      Login.count.should == 0
      visit '/auth/facebook' #capybara DSL
      User.count.should == 1
      Login.count.should == 1
      #page.should have_content("it works")
    end
  end

end
