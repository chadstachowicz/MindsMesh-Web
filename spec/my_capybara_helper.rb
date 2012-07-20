#helper methods for capybara request specs

def capybara_current_user!
  Fabricate(:entity, self_joining: true)
  visit '/auth/facebook'
  @current_user = User.last
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