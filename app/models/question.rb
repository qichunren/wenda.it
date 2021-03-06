# encoding: utf-8  
class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :answers       
  # acts_as_taggable_on :tags
  has_many :tags
  
  scope :unanswered, where("best_answer_id is null") 
  
  validates_length_of :title, :minimum => 10
  validates_length_of :content, :minimum => 30
  
  def self.hot(limit = LIMIT)
    all(:limit => limit, :order => "votes_count DESC, answers_count DESC, views_count DESC, created_at DESC")
  end
  
  def self.answered(page = 1, limit = LIMIT)
    raise "Wrong page" if page.to_i < 1
    all(:best_answer_id.ne => nil, :limit => limit, :offset => (page.to_i-1)*limit, :order => "created_at DESC")
  end

  
  def self.search(keyword, page = 1, limit = LIMIT)
    rails "Wrong page" if page.to_i < 1
    all(:title => /#{keyword}/, :limit => limit, :offset => (page.to_i-1)*limit, :order => "created_at DESC")
  end
  
  def self.answered_questions_count
    # count - count(:best_answer_id => nil)
  end      
  
  def tag_list
    self.tags.all.collect {|tag| tag.name }.join(", ")
  end
  
  def save_tags(tags)
    tags_array = []        
    tags = tags.gsub("，", ",").split(",").uniq.collect{|tag|tag.strip}
    raise "#{tags.inspect}"
    tags.gsub("，", ",").split(",").uniq.each do |tag|
      t = Tag.find_by_name(tag)
      if t
        t.questions_count += 1 if !self.has_tag(t)
      else
        t = Tag.new
        t.name = tag
      end
      t.save
      tags_array << t
    end
    self.tags = tags_array.map{|t|{"id" => t.id.to_s, "name" => t.name}}
    self.user.save_tags(tags_array)
  end
  
  def has_tag(t)
    self.tags.each do |tag|
      return true if tag["name"] == t.name
    end
    return false
  end
  
  def has_best_answer?
    !self.best_answer_id.nil?
  end
  
  def best_answer
    Answer.find(best_answer_id)
  end
end
