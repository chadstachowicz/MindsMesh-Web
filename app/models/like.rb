class Like < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :likable, polymorphic: true, counter_cache: true
  attr_accessible :user, :likable

  validates_presence_of :user
  validates_presence_of :likable
  validates_uniqueness_of :user_id, scope: [:likable_type, :likable_id]

  after_commit :lazy_notify, on: :create

  def lazy_notify
    if likable_type == 'Post'
      Stalker.enqueue('notify.new.like', id: id.to_s) unless Rails.env.test?
    end
  end

end
