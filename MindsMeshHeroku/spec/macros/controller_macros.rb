
# MindsMesh (c) 2012-2013 GPLv3

module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Fabricate(:user)
      # user.confirm!
      sign_in user
    end
  end
end
