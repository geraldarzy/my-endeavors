class AddStatusToEndeavors < ActiveRecord::Migration[5.2]
  def change
    add_column :endeavors, :status, :text
  end
end
