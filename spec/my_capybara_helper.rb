#helper methods for capybara request specs

def capybara_current_user!
  visit '/auth/facebook'
  @current_user = User.last
end

def capybara_current_user_admin!
  capybara_current_user!
  @current_user.roles += ['admin']
  @current_user.save!
end

def capybara_current_user_master!
  capybara_current_user!
  @current_user.roles += ['master']
  @current_user.save!
end