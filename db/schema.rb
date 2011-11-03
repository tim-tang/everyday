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

ActiveRecord::Schema.define(:version => 20111103030129) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "eyd_avatars", :force => true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "desc"
    t.integer  "constant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eyd_avatars", ["avatar_updated_at"], :name => "avatar_updated_at_index"
  add_index "eyd_avatars", ["constant_id"], :name => "avatar_constant_id_index"
  add_index "eyd_avatars", ["user_id"], :name => "avatar_user_id_index"

  create_table "eyd_blogs", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "video_url"
    t.text     "content"
    t.integer  "constant_id"
    t.integer  "user_id"
    t.boolean  "is_draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_count",  :default => 0
    t.string   "slug"
  end

  add_index "eyd_blogs", ["constant_id"], :name => "blog_constant_id_index"
  add_index "eyd_blogs", ["created_at"], :name => "blog_created_at_index"
  add_index "eyd_blogs", ["is_draft"], :name => "blog_is_draft_index"
  add_index "eyd_blogs", ["slug"], :name => "index_eyd_blogs_on_slug", :unique => true
  add_index "eyd_blogs", ["user_id"], :name => "blog_user_id_index"

  create_table "eyd_comments", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "blog_id"
    t.integer  "book_id"
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.boolean  "is_guestbook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eyd_comments", ["blog_id"], :name => "comment_blog_id_index"
  add_index "eyd_comments", ["is_guestbook"], :name => "comment_is_guestbook_index"

  create_table "eyd_constants", :force => true do |t|
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eyd_constants", ["user_id"], :name => "constant_user_id_index"

  create_table "eyd_ibooks", :force => true do |t|
    t.string   "ibook_file_name"
    t.string   "ibook_content_type"
    t.integer  "ibook_file_size"
    t.datetime "ibook_updated_at"
    t.string   "image_url"
    t.text     "desc"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "download_count",     :default => 0
  end

  add_index "eyd_ibooks", ["user_id"], :name => "ibook_user_id_index"

  create_table "eyd_users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
