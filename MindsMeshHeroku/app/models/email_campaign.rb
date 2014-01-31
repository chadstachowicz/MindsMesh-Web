class EmailCampaign < ActiveRecord::Base
  attr_accessible :emails_responded, :emails_sent, :entity_id, :name, :status, :type
end
