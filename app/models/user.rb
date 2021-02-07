

class User < ActiveRecord::Base
    has_many :user_endeavors
    has_many :endeavors, through: :user_endeavors
end