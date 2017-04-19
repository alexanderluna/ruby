class AddMailingListConfirmed < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :send_email, :boolean, default: true
  end
end
