class QuestionTag < ActiveRecord::Base 
  belongs_to :user
  belongs_to :question
  belongs_to :tag

  validates_presence_of :user
  validates_presence_of :question
  validates_uniqueness_of :question_id, :scope => :tag_id
end
