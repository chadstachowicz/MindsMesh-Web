require 'spec_helper'

describe "hashtags/show" do
  before(:each) do
    @hashtag = assign(:hashtag, stub_model(Hashtag,
      :entity_id => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
  end
end
