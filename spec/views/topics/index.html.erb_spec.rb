require 'spec_helper'

describe "topics/index" do
  before(:each) do
    e = Fabricate.build(:entity)
    assign(:topics, [
      stub_model(Topic,
        :entity => e,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(Topic,
        :entity => e,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of topics" do
    render
  end
end
