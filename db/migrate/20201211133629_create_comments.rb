class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :commentable, polymorphic: true
      t.text :content
    end
    add_index :comments, [:user_id, :commentable_type, :commentable_id], name: :index_comments_on_user_and_commentable
  end
end
