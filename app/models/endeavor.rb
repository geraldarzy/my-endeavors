
class Endeavor < ActiveRecord::Base


   validates :title, presence: true
   validates :description, presence: true

   
   belongs_to :user

   def get_usable_link
      self.pic.gsub(/dl=0/, "raw=1")
   end

   def picture_available?
      !!self.pic
   end

end