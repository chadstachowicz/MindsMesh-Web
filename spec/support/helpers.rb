
# MindsMesh (c) 2012-2013 GPLv3

require 'spec_helper'

 # Next two methods order columns on view
 def sort_column
    #Page.column_names.include?(params[:sort]) ? params[:sort] : "title"
 end
  
 def sort_direction
     %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
 end

