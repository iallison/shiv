class CreateAttributesTableForBoxes < ActiveRecord::Migration
  def self.up
    create_table :box_attributes do |t|
      t.integer :box_id, :null => false
      t.text :name, :null => false
      t.text :value, :null => false
      t.timestamps
    end
    add_index :box_attributes, :box_id
  end

  def self.down
    drop_table :box_attributes
  end
end
