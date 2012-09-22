class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  attr_accessible :name, :slug, :entity_user_id, :self_joining, :title, :number

  #decorator
  attr_accessor :is_my_topic



  class << self
    #untested
    def filter(q)
      where("UPPER(name) LIKE UPPER(?)", "%#{q}%")
    end
  end




  belongs_to :entity
  belongs_to :user
  has_many :topic_users, dependent: :destroy
  has_many :posts,       dependent: :destroy
  has_many :users, through: :topic_users

  validates_presence_of :name
  validates_presence_of :title
  validates_presence_of :number
  validates_presence_of :slug
  validates_presence_of :entity
  validates_presence_of :user

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  def entity_user_join(entity_user1)
    raise 'nil argument' if entity_user1.nil?
    topic_users.where(user_id: entity_user1.user.id).first_or_create
  end

  def entity_user_leave(entity_user1)
    raise 'nil argument' if entity_user1.nil?
    topic_users.where(user_id: entity_user1.user.id).first_or_initialize.destroy
  end

  attr_accessor :entity_user, :entity_user_id
  before_validation :set_entity_user_correctly, on: :create

  def set_entity_user_correctly
    if entity_user_id
      self.entity_user=EntityUser.find(entity_user_id)
    end
    if entity_user
      self.entity  = entity_user.entity
      self.user    = entity_user.user
    end
  end

  before_validation :compose_name_and_slugify

  def compose_name_and_slugify
    self.name = "#{number}: #{title}"                if self.name.blank?
    self.slug = "#{entity.name} #{name}".parameterize if self.slug.blank?
  end

end
