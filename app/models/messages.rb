class Messages < ActiveRecord::Base
  attr_accessible :expiration_date, :expired, :receiver_fb_id, :receiver_id, :replies_count, :text, :user_id
end
