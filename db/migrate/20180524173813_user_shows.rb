class UserShows < ActiveRecord::Migration
  def change
    create_table :user_shows do |t|
      t.integer :user_id
      t.integer :show_id
    end
  end
end
