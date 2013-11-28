class AdminCampaignsUsers < ActiveRecord::Base
  belongs_to :admin_campaign
  belongs_to :user
  # attr_accessible :title, :body
end
