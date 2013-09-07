class User < ActiveRecord::Base
  attr_accessor :password, :admin
  attr_accessible :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
                    :uniqueness =>  { :case_sensitive => false },
                    :format => { :with => email_regex }

  validates :password, :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }

  before_save :hash_password

  def has_password?(submitted_password)
    password_hash == hash(submitted_password)
  end

  def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      return nil  if user.nil?
      return user if user.has_password?(submitted_password)
  end
  
  private
    def hash_password
      self.salt = make_salt if new_record?
      self.password_hash = hash(password)
    end

    def hash(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
