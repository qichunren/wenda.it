# encoding: utf-8  
class Tag < ActiveRecord::Base

  
  def self.recent(limit = LIMIT)
    all(:limit => limit, :order => "created_at DESC")
  end
  
  def self.paginate(page = 1, limit = 65)
    raise "Wrong page" if page.to_i < 1
    all(:limit => limit, :offset => (page.to_i-1)*limit, :order => "questions_count DESC, created_at DESC")
  end
  
  def self.search(keyword)
    all(:name => /#{keyword}/, :limit => 65, :order => "questions_count DESC, created_at DESC")
  end
  
end
