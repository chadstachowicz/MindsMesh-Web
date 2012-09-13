require 'spec_helper'

describe 'Home' do

  describe "GET /home/index" do

    it "capybara: from login page until it creates a topic" do
      Fabricate(:entity, slug: 'uncc')
      # I'm a guest (no account)
      visit root_path
      current_path.should == home_login_path

      # - login (creating user)
      click_link('login_facebook')
      current_path.should == home_entities_path

      # - submits email to become a user
      #submits invalid email
      visit home_entities_path
      -> do
        fill_in('email', with: Faker::Internet.email)
        click_button 'submit'
      end.should change { EntityUserRequest.count }.by(0)
      page.should have_content('valid')

      #submits valid email
      visit home_entities_path
      -> do
        fill_in('email', with: "#{Faker::Internet.user_name}@uncc.edu")
        click_button 'submit'
      end.should change { EntityUserRequest.count }.by(1)
      page.should have_content('true')

      # - clicks the confirmation email (currently mocked in the view)
      #clicks invalid link
      visit home_confirm_entity_request_path('lalala')
      page.should have_content('404')
      #clicks valid link

      -> do
        -> do
          visit home_confirm_entity_request_path(User.first.entity_user_requests.first.confirmation_token)
        end.should change { EntityUserRequest.count }.by(0)
      end.should change { EntityUser.count }.by(1)

      current_path.should == home_topics_path

      #denies access
      visit root_path
      current_path.should == home_topics_path


      #modal failure
      fill_in('q',  with: "lalala")
      click_link 'Create a Class'

      fill_in('topic_title',  with: Faker::Lorem.words.join(' '))
      -> do
        -> do
          click_button 'Create Class'
        end.should_not change { TopicUser.count }
      end.should_not change { Topic.count }
      page.should have_content("can't be blank")



      #modal success
      visit home_topics_path
      fill_in('q',  with: "lalala")
      click_link 'Create a Class'

      fill_in('topic_title',  with: Faker::Lorem.words.join(' '))
      fill_in('topic_number', with: rand(999))
      -> do
        -> do
          click_button 'Create Class'
        end.should change { TopicUser.count }.by(1)
      end.should change { Topic.count }.by(1)
      page.should have_content('created_at')




      #allows access
      visit root_path
      current_path.should == root_path

    end
  end
end
