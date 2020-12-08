class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :published, default: false
      t.boolean :public, default: true
      t.integer :user_id
      t.integer :visit_count

      t.timestamps
    end
  end
end
