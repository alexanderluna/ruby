class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :user_count
      t.integer :facebook_count
      t.integer :twitter_count
      t.integer :instagram_count
      t.integer :unsubscribe_user
      t.integer :unsubscribe_person
      t.integer :micropost_count
      t.integer :commment_count
      t.integer :relationship_count
      t.integer :like_count
      t.integer :notification_count
      
      t.timestamps null: false
    end
  end
end
