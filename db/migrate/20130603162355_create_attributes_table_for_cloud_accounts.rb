class CreateAttributesTableForCloudAccount < ActiveRecord::Migration
  def self.up
    create_table :cloud_account_attributes do |t|
      t.integer :cloud_account_id, :null => false
      t.text :name, :null => false
      t.text :value, :null => false
      t.timestamps
    end
    add_index :cloud_account_attributes, :cloud_account_id
  end

  def self.down
    drop_table :cloud_account_attributes
  end
end
