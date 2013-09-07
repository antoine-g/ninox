class User < ActiveRecord::Base
  attr_accessor :password, :admin
  attr_accessible :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
                    :uniqueness =>  { :case_sensitive => false },
                    :format => { :with => email_regex }

end
