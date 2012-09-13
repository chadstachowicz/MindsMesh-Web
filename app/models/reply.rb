class Reply < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :likes,  dependent: :destroy, as: :likable
  attr_accessible :text
  validates_presence_of :post
  validates_presence_of :user
  validates_presence_of :text
  #scope :includes_all , includes(:user, :likes)

  after_create :lazy_notify

  def lazy_notify
    Notify.create(target: self) unless Rails.env.test?
  end
  
end
