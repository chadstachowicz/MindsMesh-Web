class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, polymorphic: true
  attr_accessible :action, :actors_count, :b_read, :target_id, :target_type, :user_id, :text

  validates_presence_of :user
  validates_presence_of :target
  validates_presence_of :action
  validates_presence_of :text

  # TODO: test this
  scope :unread, where(b_read: false)
  scope :read,   where(b_read: true)

  def mark_as_read
  	self.b_read = true
    save!
  end

  # TODO: test this
  def action_as_verb
    #case action
    if action == ACTION_REPLIED
      "replied to <u>#{text[0..55]}...</u>"
    elsif action == ACTION_LIKED
      "thought <u>#{text[0..40]}...</u> was inteligent"
    end
  end

  def action_replied?
    action == ACTION_REPLIED
  end

  # TODO: test this
  ACTION_REPLIED = 'replied'
  ACTION_LIKED = 'liked'

  #this model is only intended to nofity a target's owner for the time being
  def self.notify_owner(user_id, target, action, new_actors_count)
    n = where(target_type: target.class, target_id: target.id, action: action).first_or_initialize(user_id: user_id)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save!
  end

  before_validation do
    self.text = target.text[0..60]
  end
end
