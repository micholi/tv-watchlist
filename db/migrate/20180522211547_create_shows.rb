class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :genre
      t.string :description
      t.string :air_date
      t.integer :user_id
      t.integer :network_id
    end
  end
end
