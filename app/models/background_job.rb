class BackgroundJob < ActiveRecord::Base
  attr_accessible :campaign_id, :entity_id, :name, :status, :transactions, :type
end
