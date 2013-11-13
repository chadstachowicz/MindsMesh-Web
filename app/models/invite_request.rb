class InviteRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity
  belongs_to :topic
  belongs_to :group
  attr_accessible :entity_id, :topic_id, :group_id, :to_user_id, :user_id

  validates_presence_of :user
  validates_presence_of :entity

  def send_emails(emails_s)
    emails = emails_s.split(/[\s,;]/).select { |s| !s.blank? && s =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }.uniq
    logger.info "Delivering InviteRequest ##{id} to #{emails}"
    MyMail.invite(self, emails).deliver
  end

end
