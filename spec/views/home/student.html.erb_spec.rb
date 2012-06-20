require 'spec_helper'

describe "home/student.html.erb" do
  before(:each) do
    view.stub!(:current_user).and_return(current_user_student)
    assign(:posts, [
      Fabricate(:post),
      Fabricate(:post)
      ])
  end

  it "renders attributes" do
    render

    view.should render_template("/posts/_posts")
    view.should render_template("/posts/_post")

    assert_select "form", :action => home_index_path(format: 'js'), :method => "post" do
      assert_select "#section_user_id", :name => "section_user_id"
      assert_select "textarea#post_text", :name => "post[text]"
    end
  end


end
