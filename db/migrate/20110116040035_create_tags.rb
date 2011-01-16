class CreateTags < ActiveRecord::Migration
  def self.up
                   
    create_table :tags do |t|
      t.string :name 
      t.integer :original_user_id
      t.datetime :created_at
    end
    
    create_table :questions_tags do |t|
      t.integer :question_id
      t.integer :tag_id
      
      t.integer :user_id
      t.datetime :created_at
    end
    
  end

  def self.down
  end
end
