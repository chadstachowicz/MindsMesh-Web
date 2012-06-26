require 'spec_helper'

describe "posts/more_posts" do
  before do
    controller.stub!(:current_user).and_return(current_user_master)
  end

  describe "with posts" do
    before do
      assign(:posts, [])
    end

    it "doesn't render _post template" do
      render
      rendered.should_not render_template("posts/_post")
    end

    it "doesn't render next more button" do
      render
      rendered.should_not include(">MORE<")
    end
  end

  describe "with posts" do
    before do
      assign(:posts, [
        Fabricate(:post),
        Fabricate(:post)
      ])
    end

    it "renders _post template" do
      render
      rendered.should render_template("posts/_post")
    end

    it "renders next more button" do
      render
      rendered.should include(">MORE<")
    end
  end

end
