class AddSendEmail < ActiveRecord::Migration
  def change
    add_column :people, :send_email, :boolean, default: true
  end
end
