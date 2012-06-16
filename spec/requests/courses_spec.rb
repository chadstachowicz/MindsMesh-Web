require 'spec_helper'
require 'my_capybara_helper'

describe "Courses" do
  describe "GET /courses/new" do

    it "capybara: creates a course as a master" do
      Fabricate(:school)

      #doesn't allow non-masters
      capybara_current_user!
      visit new_course_path
      current_path.should_not == new_course_path

      #allows master
      capybara_current_user_master!
      visit new_course_path
      current_path.should == new_course_path

      #can create a course
      -> do
        fill_in 'course_name', with: Faker::Name.name
        click_button 'Create'
      end.should change { Course.count }.by(1)
    end
  end
end
