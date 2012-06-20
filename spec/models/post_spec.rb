require 'spec_helper'

describe Post do
  it "before" do
    Post.before(nil).should be_a(ActiveRecord::Relation)
  end
end
