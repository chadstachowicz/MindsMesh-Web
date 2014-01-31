require 'spec_helper'

describe "posts/_post" do
  before(:each) do
    @post = assign(:post, Fabricate(:post) { replies count: 3 } )
    view.stub!(:post).and_return(@post)
    view.stub!(:can?).and_return(true)
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders post text" do
    render
    rendered.should include(@post.text)
  end

  it "renders replies correctly" do
    render
    assert_select "div.reply", count: @post.replies.count
  end

  it "has post text" do
    render
    rendered.should include(@post.text), count: 1
  end

  it "renders a form for new reply" do
    #consideres everyone who is authorized to view the post can also create replies
    render
    assert_select "form#new_reply_#{@post.id}", count: 1
  end


end
