require 'spec_helper'

describe Topic do
  it "slugfies" do
  	t = Fabricate.build(:topic)
  	-> {
  	  t.valid?
  	}.should change(t, :slug)
  end
end
