class CreateAttributesTableForCloudUsers < ActiveRecord::Migration
  def self.up
    create_table :cloud_users_attributes do |t|
      t.integer :cloud_user_id, :null => false
      t.text :name, :null => false
      t.text :value, :null => false
      t.timestamps
    end
    add_index :cloud_users_attributes, :cloud_user_id
  end

  def self.down
    drop_table :cloud_users_attributes
  end
end
