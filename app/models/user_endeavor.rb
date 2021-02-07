
class User_endeavor < ActiveRecord::Base
    belongs_to :user
    belongs_to :endeavors
end