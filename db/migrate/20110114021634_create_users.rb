# encoding: utf-8 
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "salt"
      t.string   "crypted_password"
      t.string   "email"
      t.string   "identify_id"
      t.string   "avatar_path"
      t.string   "about_me"
      t.datetime "last_change_at"
      t.integer  "views_count",               :default => 0
      t.datetime "last_login_time"                     
      t.string   "last_login_ip"
      t.timestamps
    end
  end

  def self.down
  end
end
