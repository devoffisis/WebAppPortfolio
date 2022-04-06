class DeletePostIdUniqIndexFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_index :comments, [:user_id, :post_id]
  end
end
