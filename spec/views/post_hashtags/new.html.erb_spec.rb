require 'spec_helper'

describe "post_hashtags/new" do
  before(:each) do
    assign(:post_hashtag, stub_model(PostHashtag,
      :post_id => 1,
      :hashtag_id => 1
    ).as_new_record)
  end

  it "renders new post_hashtag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_hashtags_path, "post" do
      assert_select "input#post_hashtag_post_id[name=?]", "post_hashtag[post_id]"
      assert_select "input#post_hashtag_hashtag_id[name=?]", "post_hashtag[hashtag_id]"
    end
  end
end
