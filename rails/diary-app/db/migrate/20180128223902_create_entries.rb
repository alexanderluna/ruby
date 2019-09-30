class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title,  null: false
      t.text :content,  null: false
      t.datetime :date, null: false

      t.references :user, index: true, foreign_key: true
      t.timestamps  null: false
    end

    add_index :entries, [:user_id, :created_at, :date]
  end
end
