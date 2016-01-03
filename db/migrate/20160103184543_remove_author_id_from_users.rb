class RemoveAuthorIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :author_id, :integer
    add_column :votes, :author_id, :integer
  end
end
