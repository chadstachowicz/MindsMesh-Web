require 'spec_helper'

describe "PostHashtags" do
  describe "GET /post_hashtags" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get post_hashtags_path
      response.status.should be(200)
    end
  end
end
