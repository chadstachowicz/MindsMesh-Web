class Entity < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  attr_accessible :name, :slug, :self_joining, :domains, :state_name

  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users, 		    dependent: :destroy
  has_many :topics, 			        dependent: :destroy
  validates_presence_of :name
  validates_presence_of :slug
  validates_uniqueness_of :slug
  validates_presence_of :domains
  validates_presence_of :state_name

  before_validation :slugify

  def slugify
    self.slug = name.parameterize if self.slug.blank?
  end

  def as_json(options={})
    return {id: id, text: name} if options[:select2]
    super
  end

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  def user_join!(user)
    transaction do
      eu = entity_users.create!(user: user)
      user.save!
      return eu
    end
  end

  def self.find_by_email_domain(email)
    domain = email.downcase.split('@').last
    where("domains LIKE ?", "|#{domain}|").first || "@#{domain} is not in our database of valid universities and colleges in the U.S."
  end

  def self.import!(domain, name, state_name, slug_pre)
    a = create! domains: "|#{domain}|", name: name, state_name: state_name, slug: 'temp'
    a.update_attribute :slug, "#{slug_pre}-#{a.id}"
    a
  end
end
