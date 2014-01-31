class FbFriend < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend_user, class_name: 'User', foreign_key: :friend_user_id
  attr_accessible :b_same_school, :b_studying, :friend_user_id, :fb_id, :last_request_sent_at

  validates_presence_of :user
  validates_presence_of :fb_id
  validates_presence_of :last_request_sent_at

  scope :should_invite,  where('friend_user_id IS NULL').where(b_studying: true).order('last_request_sent_at')
  scope :are_registered, where('friend_user_id IS NOT NULL')
  
  #presenter
  def photo_url(picture_type='square')
    "https://graph.facebook.com/#{fb_id}/picture?type=#{picture_type}"
  end

  before_validation :define_last_request_sent_at, on: :create

  def define_last_request_sent_at
    return true unless last_request_sent_at.blank?
    t = if b_same_school
          5.years.ago
        elsif b_studying
          4.years.ago 
        else
          3.years.ago
        end
    self.last_request_sent_at = t
  end

end
