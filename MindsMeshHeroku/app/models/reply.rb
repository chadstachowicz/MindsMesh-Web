class Reply < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :likes,  dependent: :destroy, as: :likable
  has_many :notifications,   dependent: :destroy, as: :target
  attr_accessible :text
  validates_presence_of :post
  validates_presence_of :user
  validates_presence_of :text
  #scope :includes_all , includes(:user, :likes)

  after_commit :lazy_notify, on: :create

  default_scope order(:id)

  def lazy_notify
    Resque.enqueue(NotifyNewReply, id.to_s) unless Rails.env.test?
  end
  
end
