require 'spec_helper'

describe V1::BaseController do

  it "404 catch all route" do
    get :render_404
    response.status.should == 404
  end

end
