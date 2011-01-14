class CreateQuestions < ActiveRecord::Migration
  def self.up  
    create_table "questions", :force => true do |t|
      t.string  "title"
      t.text    "content"
      t.integer "votes_count",   :default => 0
      t.integer "answers_count", :default => 0
      t.integer "views_count",   :default => 0
      t.integer "user_id", :null => false
      t.integer "best_answer_id", :null => false
      t.text "tags"
      
      t.timestamps
    end
  end

  def self.down
  end
end
