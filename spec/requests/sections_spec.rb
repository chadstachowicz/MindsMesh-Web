require 'spec_helper'
require 'my_capybara_helper'

describe "Sections" do
  describe "GET /sections/new" do

    it "capybara: creates a section as an admin" do
      @school = Fabricate(:school)
      @course = Fabricate(:course)

      #doesn't allow non-admins
      capybara_current_user!
      visit new_section_path
      current_path.should_not == new_section_path

      #allows master
      capybara_current_user_admin!
      visit new_section_path
      current_path.should == new_section_path

      #can create a section
    -> do
        fill_in 'section_school_id', with: @school.id
        fill_in 'section_course_id', with: @course.id
        fill_in 'section_name',      with: Faker::Name.name
        click_button 'Create'
      end.should change { Section.count }.by(1)
    end

  end
end
