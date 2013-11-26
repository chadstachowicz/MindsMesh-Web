
# MindsMesh (c) 2012-2013 GPLv3

module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:entity_user]
      user = Fabricate(:entity_user)
      @current_user ||= Fabricate(:entity_user).user
      @current_user_master = Fabricate(:entity_user).user
      @current_user_master.role = :master
      @current_user_master.save
      @current_user_master
      # user.confirm!
      sign_in user
    end
  end
end
