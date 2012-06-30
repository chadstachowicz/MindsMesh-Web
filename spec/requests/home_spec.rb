require 'spec_helper'

describe 'Home' do


  describe "GET /home/user" do

    it "capybara: from login page until becomes a student" do
      Fabricate(:entity)
      # I'm a guest (no account)
      visit root_path
      current_path.should == home_guest_path

      # - login (creating user)
      click_link('login with facebook')
      current_path.should == home_user_path

      # - submits email to become a user
      #submits invalid email
      -> do
        fill_in('entity_user_request_email', with: Faker::Internet.email)
        click_button 'Register'
      end.should change { EntityUserRequest.count }.by(0)
      page.should have_content('alert(')

      #submits valid email
      visit home_user_path
      -> do
        fill_in('entity_user_request_email', with: "#{Faker::Internet.user_name}@uncc.edu")
        click_button 'Register'
      end.should change { EntityUserRequest.count }.by(1)
      page.should have_content('replaceWith')

      # - clicks the confirmation email (currently mocked in the view)
      #clicks invalid link
      visit home_user_entity_path('lalala')
      page.should have_content('404')
      #clicks valid link
      -> do
        -> do
          visit home_user_entity_path(User.first.entity_user_requests.first.confirmation_token)
        end.should change { EntityUserRequest.count }.by(0)
      end.should change { EntityUser.count }.by(1)
      current_path.should == home_client_path
    end
  end
end
