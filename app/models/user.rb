class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
    
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :saml, :edu_facebook]
    
  # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :twit_id, :fb_id, :tagline, :name, :avatar
  has_many :logins,               dependent: :destroy
  has_many :entity_user_requests, dependent: :destroy
  has_many :signup_requests, dependent: :destroy
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
  has_many :thread_participants

  has_many :entities, through: :entity_users
  has_many :topics,   through: :topic_users
  has_many :groups,   through: :group_users
    
  PAPERCLIP_PATH = "/system/:rails_env/:class/:id/:style"
  PAPERCLIP_OPTIONS = {path: ":rails_root/public#{PAPERCLIP_PATH}", url:  PAPERCLIP_PATH, :styles => { :medium => "300x300>", :thumb => "100x100>" }}

  has_attached_file :avatar, PAPERCLIP_OPTIONS

    
  validates_presence_of :name
  validates_uniqueness_of :email, :allow_nil => true, :allow_blank => true


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
  def school_admin?;     role_is_school?(:school_admin);     end
  def topic_admin?;     role_is_topic?(:topic_admin);     end
  def group_admin?;     role_is_group?(:group_admin);     end
  def master?;    role_is?(:master);    end

  #this should be in a presenter
  def photo_url(picture_type='square')
      if avatar.url == '/avatars/original/missing.png'
          if twit_id.nil?
              "https://graph.facebook.com/#{fb_id}/picture?type=#{picture_type}"
          else
              "https://api.twitter.com/1/users/profile_image/#{twit_id}"
          end
      else
          avatar.url(:medium)
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
    if follow_ids.length > 20
     Post.where('(user_id in (:follow_ids) and topic_id is null and group_id is null) or topic_id in (:topic_ids) or group_id in (:group_ids)', :follow_ids => follow_ids, :topic_ids => topic_ids,:group_ids => group_ids).as_feed(options)
    else
        entity_ids = entity_users.map(&:entity_id)
        eu = EntityUser.where('entity_id in (:entity_ids)',:entity_ids => entity_ids)
        user_ids = eu.map(&:user_id)
        Post.where('(user_id in (:user_ids) and topic_id is null and group_id is null) or topic_id in (:topic_ids) or group_id in (:group_ids)', :user_ids => user_ids, :topic_ids => topic_ids,:group_ids => group_ids).as_feed(options)
    end
        
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

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil, conf_token=nil)
    user = User.where(:fb_id => auth.uid).first
    unless user
    nu_email = auth.info.email
    if !conf_token.nil?
        srr = SignupRequest.find_by_confirmation_token!(conf_token)
        nu_email = srr.email
    end
    user = User.create(name:auth.extra.raw_info.name,
    fb_id:auth.uid,
    email:nu_email,
    password:Devise.friendly_token[0,20]
    )
    if !conf_token.nil?
        entity = Entity.find_by_email_domain(nu_email)
        eur = EntityUser.where(entity_id: entity.id, user_id: user.id).first_or_create
    end

    end
   user
end

def self.find_for_twitter_oauth(auth, signed_in_resource=nil, conf_token=nil)
user = User.where(:email => auth.uid).first

unless user
    nu_email = auth.info.email
    if !conf_token.nil?
        srr = SignupRequest.find_by_confirmation_token!(conf_token)
        nu_email = srr.email
    end
    user = User.create(name:auth.extra.raw_info.name,
                       twit_id:auth.uid,
                       email:nu_email,
                       password:Devise.friendly_token[0,20]
                       )
    if !conf_token.nil?
        entity = Entity.find_by_email_domain(nu_email)
        eur = user.entity_user_requests.where(entity_id: entity.id, email: nu_email).first_or_initialize
        eur.save
        eur.confirm
        text = "#{current_user.name} #joined the #{entity.name} network.  Take a moment to welcome them."
        @post = Post.where(:text => text, :user_id => user.id).create
        @tags = @post.text.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i)
                                          if !@tags.nil?
                                          @tags.each do |tag|
                                          hashtag = Hashtag.where(:name => tag[0]).first_or_create
                                          HashtagsPost.create(:post_id => @post.id, :hashtag_id => hashtag.id)
                                          end
                                          end

    end
end
user

end



def self.find_for_lti_oauth(auth, signed_in_resource=nil, entity_id)

nu_email = auth.lis_person_contact_email_primary
user = User.where(:email => auth.lis_person_contact_email_primary).first
eur = user.entity_user_requests.where(entity_id: entity_id, email: nu_email).first_or_initialize
eur.save
eur.confirm
unless user
    user = User.create(name:auth.lis_person_name_full,
                       email:nu_email,
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

  def role_is_school?(given_role_i)
    self.entity_users.each do |role|
        if role.role_i == 1
            return true
        end
    end
      return false
  end

def role_is_topic?(given_role_i)
    self.topic_users.each do |role|
        if role.role_i == 1
            return true
        end
    end
    return false
end

def role_is_group?(given_role_i)
    self.group_users.each do |role|
        if role.role_i == 1
            return true
        end
    end
    return false
end

def self.import(file)
    SmarterCSV.process(file.tempfile.to_path.to_s, {:chunk_size => 1, :key_mapping => {:course_number => :course_number, :email => :email, :name => :name, :teacher => :teacher} }) do |chunk|
        Resque.enqueue( ImportUsers, chunk ) # pass chunks of CSV-data to Resque workers for parallel processing
    end
end


end
