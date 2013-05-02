class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
    
    devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
    
  # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :twit_id, :fb_id
  attr_accessible :name
  has_many :logins,               dependent: :destroy
  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users,         dependent: :destroy
  has_many :topic_users,          dependent: :destroy
  has_many :group_users,          dependent: :destroy
  has_many :user_follows,         dependent: :destroy
  has_many :follows,  :through => :user_follows
  has_many :posts,                dependent: :destroy
  has_many :messages,             dependent: :destroy
  has_many :replies,              dependent: :destroy
  has_many :likes,                dependent: :destroy
  has_many :notifications,        dependent: :destroy
  has_many :fb_friends,           dependent: :destroy
  has_many :login_logs,           dependent: :destroy
  has_many :user_devices,         dependent: :destroy
  has_many :invite_requests,      dependent: :destroy

  has_many :entities, through: :entity_users
  has_many :topics,   through: :topic_users
  has_many :groups,   through: :group_users


  validates_presence_of :name
  #validates_presence_of :fb_id
  #validates_presence_of :fb_token
  #validates_presence_of :fb_expires_at

  #untested
  def possible_topics
    Topic.where(entity_id: entity_ids).scoped
  end

  def first_name
    name.split(' ').first
  end


  before_create :change_access_token
  after_create :joins_self_joining_entities

  def change_access_token
    self.access_token = Digest::MD5.hexdigest(Time.now.to_s+rand(999).to_s)
  end

  ROLES = {
            master:    30,
            school_admin:     20,
            faculty:   10,
            moderator: 1
          }

  def role
    ROLES.key(role_i)
  end

  def role=(given_role)
    self.role_i = 0 if given_role.nil?
    self.role_i = ROLES[given_role.to_sym] || 0
  end

  def moderator?; role_is?(:moderator); end
  #def manager?;   role_is?(:manager);   end
  #def admin?;     role_is?(:admin);     end
  def master?;    role_is?(:master);    end

  #this should be in a presenter
  def photo_url(picture_type='square')
      if twit_id.nil?
        "https://graph.facebook.com/#{fb_id}/picture?type=#{picture_type}"
      else
        "https://api.twitter.com/1/users/profile_image/#{twit_id}"
      end
  end

  #this should be in a presenter
  def fb_url
    "http://facebook.com/#{fb_id}"
  end

  def fb_api_expired?
    fb_api == :expired
  end

  def fb_api_expire!
    update_column(:fb_expires_at, 1.seconds.ago)
  end

  def fb_api
    return :expired if fb_expires_at < Time.now
    @fb_api ||= KoalaFactory.new_graph(fb_token)
  end

  def store_fb_friends!
    current_year = Date.today.year
    data = fb_api.get_object('me', fields: 'id,education,friends.fields(education)')
    
    friends = data['friends']['data']

    my_education = data['education'].to_a
    my_education = my_education.select { |e| e['year'] && e['year']['name'].to_i >= current_year }
    my_fb_school_ids = my_education.map { |fb_ed| fb_ed['school']['id'] }

    #keep them in a hash for easy access
    friends_hash   = friends.group_by { |friend_hash| friend_hash['id'] }
    #all my friends fb_id
    friends_fb_ids = friends_hash.keys
    #all my friends fb_id who were stored in DB previously
    friends_fb_ids_previous = self.fb_friends.where(fb_id: friends_fb_ids).pluck(:fb_id)
    #all my friends fb_id who were NOT stored in DB previously
    friends_fb_ids_new = friends_fb_ids - friends_fb_ids_previous


    users_already = User.where(fb_id: friends_fb_ids_new).select([:id, :fb_id])
    users_already_hash = users_already.group_by(&:fb_id)

    #store new friends
    friends_fb_ids_new.each do |fb_id|
      f = friends_hash[fb_id].first
      f_educations = f['education'].to_a.select { |e| e['year'] && e['year']['name'].to_i >= current_year }.map { |fb_ed| fb_ed['school']['id'] }
      b_studying    = f_educations.any?
      b_same_school = (f_educations & my_fb_school_ids).any?

      friend_user_id = users_already_hash[fb_id].try(:first).try(:id)
      #puts "http://facebook.com/#{fb_id}, #{b_studying}, #{b_same_school}, school: #{f_educations}" if b_studying
      self.fb_friends.create!(fb_id: fb_id, friend_user_id: friend_user_id, b_studying: b_studying, b_same_school: b_same_school)
    end
    true
  end

  def posts_feed(options={})
    topic_ids = topic_users.map(&:topic_id)
    group_ids = group_users.map(&:group_id)
    follow_ids = follow_ids(&:follows)
    follow_ids << self.id
      Post.where('(user_id in (:follow_ids) and topic_id is null and group_id is null) or topic_id in (:topic_ids) or group_id in (:group_ids)', :follow_ids => follow_ids, :topic_ids => topic_ids,:group_ids => group_ids).as_feed(options)
  end

    def posts_feed_old(options={})
        topic_ids = topic_users.map(&:topic_id)
        return [] if topic_ids.empty?
        Post.where(topic_id: topic_ids).as_feed(options)
    end
    
  def search_topics(q)
    entity_ids = entities.pluck('entities.id')
    topics = Topic.where(entity_id: entity_ids)
    return topics if q.blank?
    topics.where("name LIKE ?", "%#{q}%")
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:fb_id => auth.uid).first
    unless user
    user = User.create(name:auth.extra.raw_info.name,
    fb_id:auth.uid,
    email:auth.info.email,
    password:Devise.friendly_token[0,20]
    )
    end
   user
end

def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
user = User.where(:twit_id => auth.uid).first
unless user
    user = User.create(name:auth.extra.raw_info.name,
                       twit_id:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20]
                       )
end
user
end




  #login
  def save_with_facebook_data!(fb_uid, name, gender, token, expires_at)
    #
    self.name          = name
    self.gender        = gender
    self.fb_id         = fb_uid
    self.fb_token      = token
    self.fb_expires_at = expires_at
    #expires all cache that users user.updated_at
    self.save!
    #stores friend self
    #list.user.store_fb_friends!
  end

  private

  def joins_self_joining_entities
    Entity.self_joinings.each { |e| e.user_join!(self) }
  end

  #user matches the mininum requirement
  def role_is?(given_role_i)
    role_i >= User::ROLES[given_role_i]
  end
end
