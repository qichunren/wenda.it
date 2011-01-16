# encoding: utf-8  
class Tag < ActiveRecord::Base
  def self.recent
    all
  end
end