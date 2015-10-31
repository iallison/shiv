class CreateAttributesTableForCloudEnvironments < ActiveRecord::Migration
  def self.up
    create_table :cloud_environments_attributes do |t|
      t.integer :cloud_environments_id, :null => false
      t.text :name, :null => false
      t.text :value, :null => false
      t.timestamps
    end
    add_index :cloud_environments_attributes, :cloud_environments_id
  end

  def self.down
    drop_table :cloud_environments_attributes
  end

end
