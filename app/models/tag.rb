# encoding: utf-8  
class Tag < ActiveRecord::Base     
  has_many :question_tags
  has_many :questions, :through => :question_tags
  
  def self.recent
    all
  end
end