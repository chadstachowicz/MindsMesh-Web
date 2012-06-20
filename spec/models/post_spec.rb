require 'spec_helper'

describe Post do
  it "before" do
    Post.before(nil).should be_a(ActiveRecord::Relation)
  end
  it "as_feed" do
    Post.as_feed.should be_a(ActiveRecord::Relation)
  end
end
