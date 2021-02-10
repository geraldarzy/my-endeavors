

class User < ActiveRecord::Base
    has_secure_password                 #bcrypt, salts the password we give in, also why our password column is 'password_digest'
    has_many :endeavors
end