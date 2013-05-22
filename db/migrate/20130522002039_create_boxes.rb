class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :location
      t.string :serial
      t.string :model
      t.date :purchase_date
      t.string :vendor

      t.timestamps
    end
  end
end
