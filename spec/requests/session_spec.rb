require 'spec_helper'

describe "Session" do

  describe "GET /auth/facebook" do
    it "with capybara: triggers callback and creates Bob Example" do
      Fabricate(:entity)

      # I'm a guest
      visit root_path
      current_path.should == home_guest_path

      -> do
        -> do
          # - login (creating user)
          click_link('login_facebook')
        end.should change(User, :count).by(1)
      end.should change(Login, :count).by(1)
      current_path.should == home_client_path
    end
  end

end
