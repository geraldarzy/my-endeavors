class CreateEndeavorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :endeavors do |t|
      t.string :title
      t.text :description
    end
  end
end
