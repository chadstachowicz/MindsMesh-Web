class Reply < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likable
  attr_accessible :text
  validates_presence_of :post
  validates_presence_of :user
  validates_presence_of :text
end
