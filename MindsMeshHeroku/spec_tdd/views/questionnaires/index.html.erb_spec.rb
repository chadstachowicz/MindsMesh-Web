require 'spec_helper'

describe "questionnaires/index" do
  before(:each) do
    assign(:questionnaires, [
      Fabricate(:questionnaire),
      Fabricate(:questionnaire)
    ])
  end

  it "renders a list of questionnaires" do
    render
  end
end
