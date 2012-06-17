require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :section => nil,
      :user => nil,
      :text => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_section", :name => "post[section]"
      assert_select "input#post_user", :name => "post[user]"
      assert_select "textarea#post_text", :name => "post[text]"
    end
  end
end
