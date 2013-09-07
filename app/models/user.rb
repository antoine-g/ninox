class User < ActiveRecord::Base
  attr_accessible :admin, :email, :password_hash, :salt
end
