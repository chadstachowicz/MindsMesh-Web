
# MindsMesh, Inc. (c) 2012-2013

class Admin::CampaignsUsers < ActiveRecord::Base
  belongs_to :admin_campaign
  belongs_to :user

  attr_accessible :user_id, :delivered, :admin_campaign_id, :entity_id

end
