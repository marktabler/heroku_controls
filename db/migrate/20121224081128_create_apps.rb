class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
