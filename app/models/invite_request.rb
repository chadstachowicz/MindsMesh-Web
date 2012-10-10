class InviteRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity
  belongs_to :topic
  attr_accessible :entity_id, :topic_id

  validates_presence_of :user
  validates_presence_of :entity
  validates_presence_of :topic

  def send_emails(emails_s)
    save! #it must be saved to perform this operation
    emails = emails_s.first.split(/[\s,;]/).select { |s| !s.blank? && s =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
    emails.each do |email|
        logger.info "Delivering InviteRequest ##{id} to #{email}"
        MyMail.invite(self, email).deliver
    end
  end

end
