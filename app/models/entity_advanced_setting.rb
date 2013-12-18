
# MindsMesh (c) 2013

class EntityAdvancedSetting < ActiveRecord::Base
    attr_accessible :lti_consumer_key, :lti_consumer_secret, :entity_id, :can_create_topic, :lms_provider, :invite_template

    belongs_to :entity
end
