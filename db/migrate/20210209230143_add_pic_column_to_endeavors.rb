class AddPicColumnToEndeavors < ActiveRecord::Migration[5.2]
  def change
    add_column :endeavors, :pic, :string
  end
end
