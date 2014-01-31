require 'spec_helper'
require 'my_capybara_helper'

describe "Topics" do

  before do
    capybara_before
    capybara_current_user!
  end

=begin
  describe "GET /topics/new" do
    it "capybara: creates a topic as an admin" do
      @entity = Fabricate(:entity)

      #doesn't allow non-admins
      capybara_current_user!
      visit new_topic_path
      current_path.should_not == new_topic_path

      #allows master
      capybara_current_user_admin!
      visit new_topic_path
      current_path.should == new_topic_path

      #can create a topic
    -> do
        fill_in 'topic_entity_id', with: @entity.id
        fill_in 'topic_name',      with: Faker::Name.name
        click_button 'Create'
      end.should change { Topic.count }.by(1)
    end

  end
=end
  describe "PUT /topics/1/join" do

    it "capybara: joins a topic as a student" do
      @topic = Fabricate(:topic, entity_user: EntityUser.first)

      #sees the page
      visit topic_path(@topic)
      current_path.should == topic_path(@topic)

      #clicks 'join'
      -> do
        click_link 'join this topic'
        current_path.should == topic_path(@topic)
      end.should change(TopicUser, :count).by(1)
      -> do
        click_link 'leave this topic'
        current_path.should == topic_path(@topic)
      end.should change(TopicUser, :count).by(-1)
    end

  end

end
