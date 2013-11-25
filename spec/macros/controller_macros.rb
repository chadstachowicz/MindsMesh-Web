# Chipotle Software (c) 2013 GPLv3

module ControllerMacros 
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Fabricator(:user)
      # user.confirm!
      sign_in user
    end
  end
end
