class AddBounceCountToPerson < ActiveRecord::Migration
  def change
    add_column :people, :bounce_count, :integer, default: 0
  end
end
