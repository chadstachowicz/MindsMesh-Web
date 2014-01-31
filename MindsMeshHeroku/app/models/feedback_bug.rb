
# MindsMesh, Inc. (c) 2012-2013

class FeedbackBug < ActiveRecord::Base
    attr_accessible :request_type, :platform, :feedback, :user_id
end
