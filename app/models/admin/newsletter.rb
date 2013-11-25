
# MindsMesh, Inc. (c) 2012-2013
require 'httparty'
require 'json'
require 'cgi'
require 'date'

class Admin::Newsletter < ActiveRecord::Base

  has_many :admin_campaigns

  attr_accessible :htmlemail, :plainemail, :status, :title, :element_id, :kind
  
  attr_accessor :get_group

  scope :limited, lambda { |num| { :limit => num } }

  validates_presence_of :title, length: { is: 4 }, :message => "can't be minor to four characters"

  validates_presence_of :htmlemail, length: { is: 20 }, :message => "can't be minor to twenty characters"

  @api_base_uri = "https://api.sendgrid.com/api/"
  @pwd          = Settings.env['sendgrid']['password']
  @uname        = Settings.env['sendgrid']['username']

  class << self
      def api_base_uri() @api_base_uri; end
      def pwd() @pwd; end
      def uname() @uname; end

      def get_group(entities, kind)

        Rails.logger.debug entities.inspect if Rails.env.development?  
        # school_admin:     20, faculty:   10,   moderator: 1
        users = {admin: 'Admin', moderator: 'Moderator', student:'Student'}

        data = Array.new
        #data << {kind: kind}
        
        ents = Entity.find(entities, :select => "id,name")
        
        # Rails.logger.debug "Ents:  #{kind} \n \n"
        #raise 
        ents.each do |e|
            # Rails.logger.debug "entity: #{e.inspect}" if Rails.env.development?

            entity = {name:e.name, id: e.id}

            case kind
                when 'users'
                    entity[:users] = users

                when 'groups'
                    groups = Group.where(entity_id:e.id).select("id,name")

                    if !groups.empty?
                        entity[:groups] = groups
                    end
                    
                when 'topics'
                    topics = Topic.where(entity_id:e.id).select("id,name")
                    if !topics.empty?
                        entity[:topics] = topics 
                    end
            end
          
            # Rails.logger.debug "result: #{result.inspect} \n\n"
            data << entity    
        end

        return data

      end

    def general(from, to)

      api_options = { module:'stats', action:'getAdvanced', format:'json'}
      send_data = "?api_user=#{self.uname}&api_key=#{self.pwd}&start_date=#{from}&end_date=#{to}&data_type=global"
      url_new_string = self.api_base_uri + api_options[:module] + '.' + api_options[:action]+ '.' + api_options[:format]  + send_data
      Rails.logger.debug url_new_string if Rails.env.development?

      response =  HTTParty.post(url_new_string)  #submit the string to SG
      jparsed   = JSON.parse(response)
      data     = {json:jparsed}

      numbers  = Array.new 
      dates    = Array.new
      jparsed.each do |p|
          p["delivered"] = 0 if !p.has_key?"delivered"
          numbers << p["delivered"]
          dates   << p["date"]
      end 

      h = LazyHighCharts::HighChart.new('graph') do |f|
              f.options[:chart][:defaultSeriesType] = "line"
              f.options[:title][:text] = 'Emails Statics'
              #  f.options[:subtitle][:text] = "#{monthname} #{time.year}"
              f.options[:yAxis] = {:min => 0, :title => { :text => 'Emails' }}
              f.options[:xAxis] = {:title => { :text => 'Date' },type: 'datetime', :categories => dates}
              f.series(:name=>'Emails delivered', :data => numbers )
              f.options[:legend] = { :layout => 'vertical', :backgroundColor => '#FFFFFF', :align => 'right', :verticalAlign => 'top', :x => -10, :y => 100 }
      end

      data['chart'] = h 
      return data
    end

    def single(id)
      nl = find(id)
      api_options = { module:'stats', action:'get', format:'json'}
      formatted = CGI::escape(nl.title)
      send_data = "?api_user=#{self.uname}&api_key=#{self.pwd}&category=#{formatted}"

      url_new_string = self.api_base_uri + api_options[:module] + '.' + api_options[:action]+ '.' + api_options[:format]  + send_data

      response =  HTTParty.post(url_new_string)  #submit the string to SG
      data = JSON.parse(response)

    end

  end

end
