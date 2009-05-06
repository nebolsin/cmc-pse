# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090506145411) do

  create_table "algorithm_implementations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "algorithm_id"
    t.integer  "language_id"
    t.integer  "user_id"
    t.string   "sources_file_name"
    t.string   "sources_content_type"
    t.integer  "sources_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "algorithms", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sources_file_name"
    t.string   "sources_content_type"
    t.integer  "sources_file_size"
  end

  create_table "algorithms_computers", :force => true do |t|
    t.integer "algorithm_id"
    t.integer "computer_id"
  end

  create_table "computers", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.text     "description"
    t.string   "through_host"
    t.string   "working_directory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",              :limit => 40
    t.string   "name",               :limit => 100, :default => ""
    t.string   "email",              :limit => 100
    t.string   "salt",               :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", :limit => 128
    t.string   "token",              :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                   :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["token"], :name => "index_users_on_token"

end
