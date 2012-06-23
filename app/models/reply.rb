class Reply < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :text
  validates_presence_of :post
  validates_presence_of :user
  validates_presence_of :text
  validates_length_of :text, minimum: 10
end
