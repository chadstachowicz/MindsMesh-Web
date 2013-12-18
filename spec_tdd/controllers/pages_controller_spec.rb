require 'spec_helper'

describe PagesController do

  %w{privacy}.each do |pg|
    describe "GET '#{pg}'" do
      it "returns http success" do
        get "#{pg}"
        response.should be_success
      end
    end
  end
  %w{about faq support terms}.each do |pg|
    describe "GET '#{pg}'" do
      it "returns http success" do
        ->{
          get "#{pg}"
        }.should raise_error ActionView::MissingTemplate
      end
    end
  end

end
