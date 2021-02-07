
class Endeavor < ActiveRecord::Base
    has_many :user_endeavors
    has_many :users, through: :user_endeavors
end