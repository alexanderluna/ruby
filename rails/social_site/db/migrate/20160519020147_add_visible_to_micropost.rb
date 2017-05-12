class AddVisibleToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :visible, :boolean, default: false
  end
end
