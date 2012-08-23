require 'spec_helper'

describe "Session" do

  describe "GET /auth/facebook" do
    it "with capybara: triggers callback and creates Bob Example" do
      Fabricate(:entity)

      # I'm a guest
      visit root_path
      current_path.should == home_login_path

      -> {
        -> {
          # - login (creating user)
          click_link('login_facebook')
        }.should change(User, :count).by(1)
      }.should change(Login, :count).by(1)
      current_path.should == home_entities_path
    end
  end

end
