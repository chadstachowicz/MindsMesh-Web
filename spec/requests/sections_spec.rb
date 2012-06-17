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

  describe "PUT /sections/1/join" do

    it "capybara: joins a section as a student" do
      capybara_current_user_student!
      @section = Fabricate(:section, school: School.first)

      #sees the page
      visit section_path(@section)
      current_path.should == section_path(@section)

      #clicks 'join'
      -> do
        click_link 'join this section'
        current_path.should == section_path(@section)
      end.should change { SectionUser.count }.by(1)
      -> do
        click_link 'leave this section'
        current_path.should == section_path(@section)
      end.should change { SectionUser.count }.by(-1)
    end

  end

end
