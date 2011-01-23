# encoding: utf-8  
class User < ActiveRecord::Base

  # 
  # key :name,              String
  # key :salt,              String
  # key :crypted_password,  String
  # key :email,             String
  # key :identify_id,       String
  # key :avatar_path,       String
  # key :about_me,          String
  # key :views_count,       Integer, :default => 0
  # key :last_login_time,   Time
  # key :last_login_ip,     String
  # key :tags,              Array
  # # tags in ruby: [{"id" => "4d1033f698d1b102cb00000a", "name" => "ruby"}, {"id" => "4d1033f698d1b102cb00000b", "name" =>"rails"}]
  # # tags in bson: [{"id" : "4d1033f698d1b102cb00000a", "name" : "ruby"}, {"id" => "4d1033f698d1b102cb00000b", "name" : "rails"}]
  # timestamps!   
  
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :badges  
  # acts_as_tagger
  attr_accessor :new_password, :new_password_confirmation
  
  validates_uniqueness_of :name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create  
  
  validates_confirmation_of :new_password, :if=>:password_changed?
   
  before_save :hash_new_password, :if => :password_changed?
   
  def password_changed?
     !@new_password.blank?
  end
  
  
  
  def display_name
    self.name || self.email
  end

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user.nil?
      return nil
    elsif Digest::SHA2.hexdigest(user.salt + password) != user.crypted_password
      return nil
    end
    user
  end
  
  def self.recent(limit = LIMIT)
    all(:limit => limit, :order => "created_at DESC")
  end
  
  def self.search(keyword)
    all('$or' => [{:name => /#{keyword}/}, {:email => /#{keyword}/}], :limit => 35, :order => "created_at DESC")
  end
  
  def save_avatar(img)
    img_name = self.id.to_s + "." + img.original_filename.split(".").last
    directory = AVATAR_PATH
    abs_directory = Rails.root.to_s + "/public" + directory
    if !File.exist?(abs_directory)
      Dir.mkdir abs_directory
    end
    img_path = File.join(directory, img_name)
    abs_path = Rails.root.to_s + "/public" + img_path
    File.open(abs_path, "wb") { |f| f.write(img.read) }
    self.avatar_path = img_path
    self.save
  end
  
  def avatar
    self.avatar_path.blank?
  end
  
  def save_tags(tags)
    tags.each do |t|
      self.tags << {"id" => t.id.to_s, "name" => t.name} if !self.has_tag(t)
    end
    self.save
  end
  
  def has_tag(t)
    self.tags.each do |tag|
      return true if tag["name"] == t.name
    end
    return false
  end
  
  def questions_count
    self.questions.count
  end
  
  def answers_count
    self.answers.count
  end
  
  def comments_count
    self.comments.count
  end
  
  def tags_count
    10# self.tags.size
  end
  
  private      
  
  def hash_new_password
    # First reset the salt to a new random string.  You could choose a
    # longer string here but for a salt, 8 bytes of randomness is probably
    # fine.  Note this uses SecureRandom which will use your platform's secure
    # random number generator.
    self.salt = ActiveSupport::SecureRandom.base64(8)
    # Now calculate the hash of the password, with the salt prepended, store
    # store that in the database
    self.crypted_password = Digest::SHA2.hexdigest(self.salt + @new_password)  
  end
  
end
