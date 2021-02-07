class CreateEndeavorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :endeavors do |t|
      t.string :title
      t.text :description
      t.integer :user_id
    end
  end
end
