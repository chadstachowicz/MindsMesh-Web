require 'spec_helper'

describe "post_hashtags/edit" do
  before(:each) do
    @post_hashtag = assign(:post_hashtag, stub_model(PostHashtag,
      :post_id => 1,
      :hashtag_id => 1
    ))
  end

  it "renders the edit post_hashtag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_hashtag_path(@post_hashtag), "post" do
      assert_select "input#post_hashtag_post_id[name=?]", "post_hashtag[post_id]"
      assert_select "input#post_hashtag_hashtag_id[name=?]", "post_hashtag[hashtag_id]"
    end
  end
end
