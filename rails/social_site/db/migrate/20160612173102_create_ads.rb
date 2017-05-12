class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|

      t.string :big_ad
      t.string :banner_ad

      t.timestamps null: false
    end
  end
end
