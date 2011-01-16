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

ActiveRecord::Schema.define(:version => 20110116040035) do

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "votes_count", :default => 0
    t.integer  "user_id",                    :null => false
    t.integer  "question_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "votes_count",    :default => 0
    t.integer  "answers_count",  :default => 0
    t.integer  "views_count",    :default => 0
    t.integer  "user_id",                       :null => false
    t.integer  "best_answer_id",                :null => false
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_tags", :force => true do |t|
    t.integer  "question_id"
    t.integer  "tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "original_user_id"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "salt"
    t.string   "crypted_password"
    t.string   "email"
    t.string   "identify_id"
    t.string   "avatar_path"
    t.string   "about_me"
    t.datetime "last_change_at"
    t.integer  "views_count",      :default => 0
    t.datetime "last_login_time"
    t.string   "last_login_ip"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
