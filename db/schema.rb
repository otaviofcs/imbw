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

ActiveRecord::Schema.define(:version => 20090721015044) do

  create_table "beer_votes", :force => true do |t|
    t.string   "title"
    t.float    "vote"
    t.string   "comment"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_profile"
    t.datetime "commented_at"
  end

  create_table "galleries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gallery_hash"
    t.string   "public_code"
  end

  create_table "links", :force => true do |t|
    t.string   "link"
    t.string   "description"
    t.string   "title"
    t.datetime "linked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "gallery_id"
    t.string   "title"
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.string   "photo_hash"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "body",                           :null => false
    t.boolean  "active",       :default => true, :null => false
    t.datetime "published_at"
    t.datetime "edited_at",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "posts", ["published_at"], :name => "index_posts_on_published_at"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                               :null => false
    t.string   "crypted_password",                                    :null => false
    t.string   "password_salt",                                       :null => false
    t.string   "persistence_token",                                   :null => false
    t.string   "single_access_token",                                 :null => false
    t.string   "perishable_token",                                    :null => false
    t.integer  "login_count",                          :default => 0, :null => false
    t.integer  "failed_login_count",                   :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone",             :limit => 100
    t.string   "email"
    t.string   "twitter_profile"
    t.string   "twitter_profile_image"
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
