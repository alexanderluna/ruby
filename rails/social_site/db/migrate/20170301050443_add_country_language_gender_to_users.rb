class AddCountryLanguageGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :language, :string
    add_column :users, :gender, :string
  end
end
