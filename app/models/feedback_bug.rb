class FeedbackBug < ActiveRecord::Base
    attr_accessible :request_type, :platform, :feedback
end
