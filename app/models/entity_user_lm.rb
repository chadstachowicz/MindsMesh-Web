class EntityUserLm < ActiveRecord::Base
  attr_accessible :lms_provider_id, :token, :user_id
end
