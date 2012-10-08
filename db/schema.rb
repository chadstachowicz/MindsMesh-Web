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

ActiveRecord::Schema.define(:version => 20120927225507) do

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
    t.integer  "entity_users_count"
    t.integer  "topics_count"
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

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "text"
    t.integer  "likes_count",   :default => 0
    t.integer  "replies_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
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
    t.string   "key",                        :null => false
    t.string   "environment",                :null => false
    t.text     "certificate",                :null => false
    t.string   "password"
    t.integer  "connections", :default => 1, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
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
    t.string   "device_token",          :limit => 64,                       :null => false
    t.string   "sound",                               :default => "1.aiff"
    t.string   "alert"
    t.text     "attributes_for_device"
    t.integer  "expiry",                              :default => 86400,    :null => false
    t.boolean  "delivered",                           :default => false,    :null => false
    t.datetime "delivered_at"
    t.boolean  "failed",                              :default => false,    :null => false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.string   "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.boolean  "alert_is_json",                       :default => false
    t.string   "app"
  end

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

  create_table "topic_users", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.string   "role"
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
  end

  add_index "topics", ["entity_id"], :name => "index_topics_on_entity_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "fb_id"
    t.string   "fb_token"
    t.datetime "fb_expires_at"
    t.integer  "role_i",             :default => 0
    t.integer  "posts_count",        :default => 0
    t.integer  "replies_count",      :default => 0
    t.integer  "likes_count",        :default => 0
    t.integer  "topic_users_count",  :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "access_token"
    t.datetime "last_login_at"
    t.integer  "entity_users_count"
  end

end
