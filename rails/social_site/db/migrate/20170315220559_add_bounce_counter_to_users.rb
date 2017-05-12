class AddBounceCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bounce_count, :integer, default: 0
  end
end
