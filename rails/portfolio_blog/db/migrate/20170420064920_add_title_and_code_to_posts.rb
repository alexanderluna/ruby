class AddTitleAndCodeToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :code_snippet, :text
    add_column :posts, :title, :text
    add_column :posts, :image, :text 
  end
end
