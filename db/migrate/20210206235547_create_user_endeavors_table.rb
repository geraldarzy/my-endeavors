class CreateUserEndeavorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_endeavors do |t|
      t.integer :user_id
      t.integer :endeavor_id
    end
  end
end
