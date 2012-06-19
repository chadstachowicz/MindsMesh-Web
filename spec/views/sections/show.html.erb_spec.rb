require 'spec_helper'

describe "sections/show" do
  before(:each) do
    @section = assign(:section, Fabricate(:section))
    assign(:section_user, nil)
    assign(:section_users, [
      Fabricate.build(:section_user),
      Fabricate.build(:section_user)
      ])
    assign(:post, stub_model(Post,
      :text => "MyText"
    ).as_new_record)
    assign(:posts, [
      Fabricate(:post),
      Fabricate(:post)
      ])
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders attributes in <p>" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_section_path(@section), :method => "post" do
      assert_select "textarea#post_text", :name => "post[text]"
    end
  end

end
