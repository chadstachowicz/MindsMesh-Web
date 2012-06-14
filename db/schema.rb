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

ActiveRecord::Schema.define(:version => 20120614165919) do

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

  create_table "school_user_requests", :force => true do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.string   "email"
    t.string   "confirmation_token"
    t.datetime "last_email_sent_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "school_user_requests", ["school_id"], :name => "index_school_user_requests_on_school_id"
  add_index "school_user_requests", ["user_id"], :name => "index_school_user_requests_on_user_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "photo_url"
    t.string   "roles_s"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
