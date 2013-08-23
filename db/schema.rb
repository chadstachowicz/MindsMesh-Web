# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130823052956) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "self_joining",       :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "domains"
    t.string   "state_name"
    t.integer  "entity_users_count", :default => 0
    t.integer  "topics_count",       :default => 0
    t.string   "moodle_url"
    t.integer  "groups_count"
  end

  create_table "entity_advanced_settings", :force => true do |t|
    t.string   "lti_consumer_key"
    t.string   "lti_consumer_secret"
    t.integer  "lms_provider"
    t.integer  "can_create_topic"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "entity_id"
  end

  create_table "entity_lms", :force => true do |t|
    t.integer  "lms_provider_id"
    t.integer  "entity_id"
    t.string   "version"
    t.string   "host"
    t.integer  "secure"
    t.string   "lti_guid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "entity_user_lms", :force => true do |t|
    t.integer  "entity_lms_id"
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "entity_user_requests", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.string   "email"
    t.string   "confirmation_token"
    t.datetime "last_email_sent_at"
    t.datetime "confirmed_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "entity_user_requests", ["entity_id"], :name => "index_entity_user_requests_on_entity_id"
  add_index "entity_user_requests", ["user_id"], :name => "index_entity_user_requests_on_user_id"

  create_table "entity_users", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_i"
  end

  add_index "entity_users", ["entity_id"], :name => "index_entity_users_on_entity_id"
  add_index "entity_users", ["user_id"], :name => "index_entity_users_on_user_id"

  create_table "fb_friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_user_id"
    t.string   "fb_id"
    t.boolean  "b_studying"
    t.boolean  "b_same_school"
    t.datetime "last_request_sent_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "fb_friends", ["friend_user_id"], :name => "index_fb_friends_on_friend_user_id"
  add_index "fb_friends", ["user_id"], :name => "index_fb_friends_on_user_id"

  create_table "feedback_bugs", :force => true do |t|
    t.integer  "user_id"
    t.string   "request_type"
    t.text     "feedback"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "platform"
  end

  create_table "group_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_i"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
  end

  create_table "groups", :force => true do |t|
    t.integer  "entity_id"
    t.string   "name"
    t.string   "slug"
    t.integer  "group_users_count", :default => 0
    t.integer  "posts_count",       :default => 0
    t.string   "description"
    t.integer  "user_id"
    t.integer  "privacy",           :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "hashtags", :force => true do |t|
    t.integer  "entity_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hashtags_posts", :force => true do |t|
    t.integer  "post_id"
    t.integer  "hashtag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invite_requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entity_id"
    t.integer  "topic_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "confirmation_token"
  end

  add_index "invite_requests", ["entity_id"], :name => "index_invite_requests_on_entity_id"
  add_index "invite_requests", ["topic_id"], :name => "index_invite_requests_on_topic_id"
  add_index "invite_requests", ["user_id"], :name => "index_invite_requests_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.string   "likable_type"
    t.integer  "likable_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "likes", ["likable_type", "likable_id"], :name => "index_likes_on_likable_type_and_likable_id"
  add_index "likes", ["user_id", "likable_type"], :name => "index_likes_on_user_id_and_likable_type"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "lms_providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "login_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_agent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "login_logs", ["user_id"], :name => "index_login_logs_on_user_id"

  create_table "logins", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.text     "auth_s"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "logins", ["provider", "uid"], :name => "index_logins_on_provider_and_uid"
  add_index "logins", ["user_id"], :name => "index_logins_on_user_id"

  create_table "message_attachments", :force => true do |t|
    t.integer  "message_id"
    t.string   "subtype"
    t.string   "link_url"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "message_attachments", ["message_id"], :name => "index_message_attachments_on_message_id"

  create_table "message_read_states", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "read_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_threads", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "thread_id"
    t.text     "text"
    t.integer  "replies_count"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "message_thread_id"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "b_read",           :default => false
    t.string   "action"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "actors_count",     :default => 0
    t.string   "text"
    t.string   "fb_apprequest_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "notifications", ["fb_apprequest_id"], :name => "index_notifications_on_fb_apprequest_id"
  add_index "notifications", ["target_type", "target_id"], :name => "index_notifications_on_target_type_and_target_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "notifies", :force => true do |t|
    t.string   "target_type"
    t.integer  "target_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "notifies", ["target_type"], :name => "index_notifies_on_target_type"

  create_table "post_attachments", :force => true do |t|
    t.integer  "post_id"
    t.string   "subtype"
    t.string   "link_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "post_attachments", ["post_id"], :name => "index_post_attachments_on_post_id"

  create_table "post_hashtags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "hashtag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "text"
    t.integer  "likes_count",   :default => 0
    t.integer  "replies_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "group_id"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questionnaires", :force => true do |t|
    t.integer  "user_id"
    t.text     "q1"
    t.text     "q2"
    t.text     "q3"
    t.text     "q4"
    t.text     "q5"
    t.text     "q6"
    t.text     "q7"
    t.text     "q8"
    t.text     "q9"
    t.text     "q10"
    t.text     "q11"
    t.text     "q12"
    t.text     "q13"
    t.text     "q14"
    t.text     "q15"
    t.text     "q16"
    t.text     "q17"
    t.text     "q18"
    t.text     "q19"
    t.text     "q20"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questionnaires", ["user_id"], :name => "index_questionnaires_on_user_id"

  create_table "rapns_apps", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections", :default => 1, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "type",                       :null => false
    t.string   "auth_key"
  end

  create_table "rapns_feedback", :force => true do |t|
    t.string   "device_token", :limit => 64, :null => false
    t.datetime "failed_at",                  :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "app"
  end

  add_index "rapns_feedback", ["device_token"], :name => "index_rapns_feedback_on_device_token"

  create_table "rapns_notifications", :force => true do |t|
    t.integer  "badge"
    t.string   "device_token",      :limit => 64
    t.string   "sound",                                 :default => "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                                :default => 86400
    t.boolean  "delivered",                             :default => false,     :null => false
    t.datetime "delivered_at"
    t.boolean  "failed",                                :default => false,     :null => false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.boolean  "alert_is_json",                         :default => false
    t.string   "type",                                                         :null => false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",                      :default => false,     :null => false
    t.text     "registration_ids",  :limit => 16777215
    t.integer  "app_id",                                                       :null => false
    t.integer  "retries",                               :default => 0
  end

  add_index "rapns_notifications", ["app_id", "delivered", "failed", "deliver_after"], :name => "index_rapns_notifications_multi"
  add_index "rapns_notifications", ["delivered", "failed", "deliver_after"], :name => "index_rapns_notifications_on_delivered_failed_deliver_after"

  create_table "replies", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "text"
    t.integer  "likes_count", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "replies", ["post_id"], :name => "index_replies_on_post_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "signup_requests", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.string   "email"
    t.string   "confirmation_token"
    t.datetime "last_email_sent_at"
    t.datetime "confirmed_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "thread_participants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_thread_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "topic_users", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "role_i"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topic_users", ["topic_id"], :name => "index_topic_users_on_topic_id"
  add_index "topic_users", ["user_id"], :name => "index_topic_users_on_user_id"

  create_table "topics", :force => true do |t|
    t.integer  "entity_id"
    t.string   "name"
    t.string   "slug"
    t.boolean  "self_joining",      :default => false
    t.integer  "topic_users_count", :default => 0
    t.integer  "posts_count",       :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "title"
    t.string   "number"
    t.integer  "user_id"
    t.integer  "privacy",           :default => 0
    t.integer  "entity_lms_id"
  end

  add_index "topics", ["entity_id"], :name => "index_topics_on_entity_id"

  create_table "user_devices", :force => true do |t|
    t.integer  "user_id"
    t.string   "os"
    t.string   "model"
    t.string   "name"
    t.string   "token"
    t.string   "environment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_devices", ["user_id", "token"], :name => "index_user_devices_on_user_id_and_token"
  add_index "user_devices", ["user_id"], :name => "index_user_devices_on_user_id"

  create_table "user_follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_follows", ["follow_id"], :name => "index_user_follows_on_follow_id"
  add_index "user_follows", ["user_id"], :name => "index_user_follows_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "fb_id"
    t.string   "fb_token"
    t.datetime "fb_expires_at"
    t.integer  "role_i",                 :default => 0
    t.integer  "posts_count",            :default => 0
    t.integer  "replies_count",          :default => 0
    t.integer  "likes_count",            :default => 0
    t.integer  "topic_users_count",      :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "access_token"
    t.datetime "last_login_at"
    t.integer  "entity_users_count",     :default => 0
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.integer  "group_users_count"
    t.integer  "twit_id"
    t.string   "tagline"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
