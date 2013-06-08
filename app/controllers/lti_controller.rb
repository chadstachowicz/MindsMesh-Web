class LtiController < ApplicationController

    
  def index
      require 'ims/lti'
    provider = IMS::LTI::ToolProvider.new("elondev", "Elon2013", params)
      
      if provider.valid_request?(request)
          flash[:notice] = "Valid Moodle"
      else
          flash[:notice] = "Invalid Moodle"
      end
      
    redirect_to_landing_home_page
  end

 
end
