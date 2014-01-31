require 'spec_helper'

describe MetricsHelper do
  describe "google_analytics" do
    it "should return nil in test env" do
      helper.google_analytics.should be_nil
    end
  end
  describe "crazy_egg" do
    it "should return nil in test env" do
      helper.crazy_egg.should be_nil
    end
  end
end
