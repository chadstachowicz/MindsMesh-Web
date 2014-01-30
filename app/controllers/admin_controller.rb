class AdminController < ApplicationController

  authorize_resource class: false

  def denied
    redirect_to_landing_home_page
  end

      def index
        users_joined = Report::Users.users_joined(params[:daterange])
          daterange = params[:daterange]
          if daterange.nil? || daterange.empty?
              date_from  = Date.today.beginning_of_month
              date_to    = Date.today.end_of_month
              date_range = date_from..date_to
          else
              date_a = daterange.split(" - ")
              startdate = Date.strptime date_a[0], "%m/%d/%Y"
              enddate = Date.strptime date_a[1], "%m/%d/%Y"
          end
          
          @h = LazyHighCharts::HighChart.new('graph') do |f|
              f.options[:chart][:defaultSeriesType] = "line"
              f.options[:title][:text] = 'Monthly New User Statistics'
            #  f.options[:subtitle][:text] = "#{monthname} #{time.year}"
              f.options[:yAxis] = {:min => 0, :title => { :text => 'Users' }}
              f.options[:xAxis] = {:title => { :text => 'Date' },type: 'datetime', :categories => date_range, :labels => {:rotation => -90, :align => 'right'}}
              f.series(:name=>'Users Joined', :data=> users_joined)
              f.options[:legend] = { :layout => 'vertical', :backgroundColor => '#FFFFFF', :align => 'right', :verticalAlign => 'top', :x => -10, :y => 100 }
          end
          respond_to do |format|
              format.html # index.html.erb
          end
      end


end
