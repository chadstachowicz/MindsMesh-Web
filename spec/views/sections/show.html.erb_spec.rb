require 'spec_helper'

describe "sections/show" do
  before(:each) do
    @section = assign(:section, Fabricate(:section))
    assign(:section_user, nil)
    assign(:section_users, [
      Fabricate.build(:section_user),
      Fabricate.build(:section_user)
      ])
    assign(:posts, [
      Fabricate(:post),
      Fabricate(:post)
      ])
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders attributes in <p>" do
    render
    view.should render_template("/posts/_posts")
    view.should render_template("/posts/_post")
  end

end
