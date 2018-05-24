class RenameColumnInShows < ActiveRecord::Migration
  def change
    rename_column :shows, :user_id, :owner_id
  end
end
