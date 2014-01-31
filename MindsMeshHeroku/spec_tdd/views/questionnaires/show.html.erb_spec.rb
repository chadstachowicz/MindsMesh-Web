require 'spec_helper'

describe "questionnaires/show" do
  before(:each) do
    q = Fabricate(:questionnaire)
    assign(:questionnaire, q)
    assign(:previous, q)
    assign(:next, q)
  end

  it "renders a questionnaire" do
    render
  end
end
