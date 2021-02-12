class AddPicCaptionColumnToEndeavors < ActiveRecord::Migration[5.2]
  def change
    add_column :endeavors, :pic_caption, :text
  end
end
