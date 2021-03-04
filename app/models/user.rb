

class User < ActiveRecord::Base
    validates :username, presence:true
    validates :username, uniqueness:true
    validates :password, presence:true
    
    has_secure_password                 #bcrypt, salts the password we give in, also why our password column is 'password_digest'
    has_many :endeavors
end