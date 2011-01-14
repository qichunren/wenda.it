# encoding: utf-8  
class CreateAnswers < ActiveRecord::Migration
  def self.up   
    create_table "answers", :force => true do |t|
      t.text   "content"      
      t.integer "votes_count", :default => 0
      t.integer "user_id", :null => false
      t.integer "question_id", :null => false
      t.timestamps
    end
  end

  def self.down
  end
end
