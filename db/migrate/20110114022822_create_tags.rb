# encoding: utf-8 
class CreateTags < ActiveRecord::Migration
  def self.up   
    create_table "tags", :force => true do |t|  
      t.string "name"
      t.integer "questions_count", :default => 1
      t.timestamps
    end
  end

  def self.down
  end
end
