require 'spec_helper'

describe "posts/_post" do
  before(:each) do
    @post = assign(:post, Fabricate(:post))
    @count = 3
    @replies = (1..@count).to_a.map {
      Fabricate(:reply, post: @post)
    }
    view.stub!(:post).and_return(@post)
  end

  it "renders post text" do
    render
    rendered.should include(@post.text)
  end

  it "renders replies correctly" do
    render
    assert_select "div.reply", count: @count
    @replies.each do |reply|
      rendered.should include(reply.text)
    end
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
