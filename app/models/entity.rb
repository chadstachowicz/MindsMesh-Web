
# MindsMesh (c) 2013

class Entity < ActiveRecord::Base

  attr_accessible :name, :slug, :self_joining, :domains, :state_name, :moodle_url, :token, :moodle_sso

  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users, 		    dependent: :destroy
  has_many :hashtags, 		    dependent: :destroy
  has_one :entity_advanced_setting,     dependent: :destroy
  has_many :topics, 			        dependent: :destroy

  validates_presence_of :name
  validates_presence_of :domains
  validates_presence_of :state_name

  #field slug is generated
  validates_presence_of :slug
  validates_uniqueness_of :slug
  before_validation :slugify

  def slugify
    self.slug = self.name.parameterize if self.slug.blank?
  end

  def as_json(options={})
    return {id: id, text: name} if options[:select2]
    super
  end

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  # entity_users
  def user_join!(user)
    transaction do
      eu = entity_users.create!(user: user)
      user.save!
      return eu
    end
  end

  # check if the domain in email exist
  def self.find_by_email_domain(email)
    domain = email.downcase.split('@').last
    domain_split = domain.split('.')
    domain = domain_split[-2] + '.' + domain_split[-1]
    where("domains LIKE ?", "|#{domain}|").first || "@#{domain} is not in our database of valid universities and colleges in the U.S."
    #where("domains LIKE ?", "#{domain}").first || "@#{domain} is not in our database of valid universities and colleges in the U.S."
  end

  def self.import!(domain, name, state_name, slug_pre)
    a = create! domains: "|#{domain}|", name: name, state_name: state_name, slug: 'temp'
    a.update_attribute :slug, "#{slug_pre}-#{a.id}"
    a
  end
end

