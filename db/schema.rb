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

ActiveRecord::Schema.define(:version => 20130506074646) do

  create_table "broadcasts", :force => true do |t|
    t.string   "description"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "broadcasts_channels", :force => true do |t|
    t.integer "broadcast_id"
    t.integer "channel_id"
  end

  add_index "broadcasts_channels", ["broadcast_id", "channel_id"], :name => "index_broadcasts_channels_on_broadcast_id_and_channel_id"
  add_index "broadcasts_channels", ["channel_id", "broadcast_id"], :name => "index_broadcasts_channels_on_channel_id_and_broadcast_id"

  create_table "broadcasts_users", :force => true do |t|
    t.integer "broadcast_id"
    t.integer "user_id"
  end

  add_index "broadcasts_users", ["broadcast_id", "user_id"], :name => "index_broadcasts_users_on_broadcast_id_and_user_id"
  add_index "broadcasts_users", ["user_id", "broadcast_id"], :name => "index_broadcasts_users_on_user_id_and_broadcast_id"

  create_table "channels", :force => true do |t|
    t.string   "description",    :null => false
    t.string   "value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "spreadsheet_id"
    t.integer  "owner_id"
    t.integer  "assignee_id"
  end

  add_index "channels", ["assignee_id"], :name => "index_channels_on_assignee_id"
  add_index "channels", ["owner_id"], :name => "index_channels_on_owner_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "signups", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spreadsheets", :force => true do |t|
    t.string   "filename",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner_id"
  end

  add_index "spreadsheets", ["owner_id"], :name => "index_spreadsheets_on_owner_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "spreadsheet_id"
    t.string   "metadata"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subscriptions", ["channel_id", "spreadsheet_id"], :name => "index_subscriptions_on_channel_id_and_spreadsheet_id"
  add_index "subscriptions", ["spreadsheet_id", "channel_id"], :name => "index_subscriptions_on_spreadsheet_id_and_channel_id"

  create_table "teams", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id", "user_id"], :name => "index_teams_users_on_team_id_and_user_id"
  add_index "teams_users", ["user_id", "team_id"], :name => "index_teams_users_on_user_id_and_team_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
    t.string   "name"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
