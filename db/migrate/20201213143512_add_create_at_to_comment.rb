class AddCreateAtToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :created_at, :datetime, null: false
  end
end
