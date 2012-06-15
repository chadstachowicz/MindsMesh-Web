require 'spec_helper'

describe 'Home' do


  describe "GET /home/user" do

    it "capybara: from login page until becomes a student" do
      Fabricate(:school)
      # I'm a guest
      visit home_index_path
      current_path.should == home_guest_path

      # - login (creating user)
      click_link('login with facebook')
      current_path.should == home_user_path

      # - submits email to become a student
      #submits invalid email
      -> do
        fill_in('school_user_request_email', with: Faker::Internet.email)
        click_button 'Register'
      end.should change { SchoolUserRequest.count }.by(0)
      page.should have_content('alert(')

      #submits valid email
      visit home_user_path
      -> do
        fill_in('school_user_request_email', with: "#{Faker::Internet.user_name}@uncc.edu")
        click_button 'Register'
      end.should change { SchoolUserRequest.count }.by(1)
      page.should have_content('$("body").append')

      # - clicks the confirmation email (currently mocked in the view)
      #clicks invalid link
      visit home_user_school_path('lalala')
      page.should have_content('404')
      #clicks valid link
      -> do
        -> do
          visit home_user_school_path(User.first.school_user_requests.first.confirmation_token)
        end.should change { SchoolUserRequest.count }.by(-1)
      end.should change { SchoolUser.count }.by(1)
      current_path.should == home_student_path
    end
  end
end
