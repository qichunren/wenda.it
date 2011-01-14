# encoding: utf-8  
class Comment < ActiveRecord::Base


  # key :content,     String
  # key :user_id,     ObjectId
  # key :answer_id, ObjectId
  # timestamps!        
  
  belongs_to :user
  belongs_to :answer
end
