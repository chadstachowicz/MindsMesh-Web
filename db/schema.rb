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

ActiveRecord::Schema.define(:version => 20120622210246) do

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entity_user_requests", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "user_id"
    t.string   "email"
    t.string   "confirmation_token"
    t.datetime "last_email_sent_at"
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

  create_table "logins", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "permissions_s"
    t.string   "auth_s"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "logins", ["user_id"], :name => "index_logins_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "topic_user_id"
    t.text     "text"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["topic_user_id"], :name => "index_posts_on_topic_user_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "replies", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["entity_id"], :name => "index_topics_on_entity_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "photo_url"
    t.string   "roles_s"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
