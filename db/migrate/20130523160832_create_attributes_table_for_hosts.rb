class CreateAttributesTableForHosts < ActiveRecord::Migration
  def self.up
    create_table :host_attributes do |t|
      t.integer :host_id, :null => false
      t.text :name, :null => false
      t.text :value, :null => false
      t.timestamps
    end
    add_index :host_attributes, :host_id
  end

  def self.down
    drop_table :host_attributes
  end
end
