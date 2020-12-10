class CreateUsersBlockship < ActiveRecord::Migration[6.0]
  def change
    create_table :users_blockship, id: false do |t|
      t.references :user
      t.references :block_user
    end
    add_index(:users_blockship, [:user_id, :block_user_id], unique: true)
    add_index(:users_blockship, [:block_user_id, :user_id], unique: true)

  end
end
