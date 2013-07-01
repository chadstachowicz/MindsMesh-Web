class EntityLm < ActiveRecord::Base
  attr_accessible :entity_id, :host, :lms_provider_id, :lti-guid, :secure, :version
end
