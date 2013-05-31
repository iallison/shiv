class CreateCloudAccounts < ActiveRecord::Migration
  def change
    create_table :cloud_accounts do |t|
      t.string :name
      t.string :charge_index
      t.string :customer_type
      t.string :organization

      t.timestamps
    end
  end
end
