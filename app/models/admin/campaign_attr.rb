
# MindsMesh, Inc. (c) 2012-2013

class Admin::CampaignAttr < ActiveRecord::Base

  belongs_to :admin_campaign

  attr_accessible :key, :value, :entity_id

end
