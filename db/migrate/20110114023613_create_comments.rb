# encoding: utf-8 
class CreateComments < ActiveRecord::Migration
  def self.up   
    create_table "comments", :force => true do |t|
      t.integer "user_id"
      t.integer "answer_id"
      t.text "content"
      t.timestamps
    end
  end

  def self.down
  end
end
