# encoding: utf-8  
class CreateBadges < ActiveRecord::Migration
  def self.up 
    create_table "badges", :force => true do |t|
      t.string "name"
      
      t.timestamps
    end
  end

  def self.down
  end
end
