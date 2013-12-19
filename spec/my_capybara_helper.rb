#helper methods for capybara request specs

def capybara_before
  ActionDispatch::Request.any_instance.stub(user_agent: 'capybara')
end

def capybara_current_user!
  visit '/auth/facebook'
  @current_user = User.last
  Fabricate(:entity_user, user: @current_user)
end

def capybara_current_user_admin!
  capybara_current_user!
  @current_user.role = :admin
  @current_user.save!
end

def capybara_current_user_master!
  capybara_current_user!
  @current_user.role = :master
  @current_user.save!
end