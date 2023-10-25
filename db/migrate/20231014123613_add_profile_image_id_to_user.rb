class AddProfileImageIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :book_id, :string
  end
end
