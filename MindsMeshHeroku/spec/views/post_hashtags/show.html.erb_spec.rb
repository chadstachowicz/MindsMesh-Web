require 'spec_helper'

describe "post_hashtags/show" do
  before(:each) do
    @post_hashtag = assign(:post_hashtag, stub_model(PostHashtag,
      :post_id => 1,
      :hashtag_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
