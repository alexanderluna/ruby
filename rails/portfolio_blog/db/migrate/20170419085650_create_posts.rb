class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :git_link
      t.integer :views

      t.references :section, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
    add_index :posts, [:user_id, :section_id, :created_at]
  end
end
