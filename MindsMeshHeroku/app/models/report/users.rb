
# MindsMesh, Inc. (c) 2012-2013

class Report::Users < ActiveRecord::Base

  def self.users_joined(daterange)
	totalcounts = []
	if daterange.nil? || daterange.empty?
	  currenttime = Time.new
	  time = Date.new(currenttime.year, currenttime.month).to_time
	  monthname = Date::MONTHNAMES[time.month] 
	  @users = User.find(:all, :conditions => ['created_at >= ? AND created_at <= ?', time.at_beginning_of_month, time.at_end_of_month])
	  Date.new(currenttime.year, currenttime.month).at_beginning_of_month.upto(Date.new(currenttime.year, currenttime.month).at_end_of_month) do |date|
      totalcounts << @users.select{|u| u.created_at.to_s =~ /#{date.to_s}/}.size

	  end
	else 
	
	date_a = daterange.split(" - ")
	startdate = Date.strptime date_a[0], "%m/%d/%Y"
	enddate = Date.strptime date_a[1], "%m/%d/%Y"

	
	  @users = User.find(:all, :conditions => ['created_at >= ? AND created_at <= ?', startdate, enddate])
	  startdate.upto(enddate) do |date|
          totalcounts << @users.select{|u| u.created_at.to_s =~ /#{date.to_s}/ }.size
	  end
	end
	
	return totalcounts
  end
  
end
