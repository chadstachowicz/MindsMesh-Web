require 'spec_helper'

%w{privacy}.each do |pg|
	describe "pages/#{pg}.html.erb" do
	  it "renders" do
	  	render
	  end
	end
end

%w{about faq support terms}.each do |pg|
	describe "pages/#{pg}.html.erb" do
	  it "renders" do
	  	->{
	  	  render
	  	}.should raise_error ActionView::MissingTemplate
	  end
	end
end
