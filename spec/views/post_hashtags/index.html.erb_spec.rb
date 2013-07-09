require 'spec_helper'

describe "post_hashtags/index" do
  before(:each) do
    assign(:post_hashtags, [
      stub_model(PostHashtag,
        :post_id => 1,
        :hashtag_id => 2
      ),
      stub_model(PostHashtag,
        :post_id => 1,
        :hashtag_id => 2
      )
    ])
  end

  it "renders a list of post_hashtags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
