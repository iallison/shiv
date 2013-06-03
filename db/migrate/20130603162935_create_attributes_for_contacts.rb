class CreateAttributesForContacts < ActiveRecord::Migration
  def up
    def self.up
      create_table :contact_attributes do |t|
        t.integer :contact_id, :null => false
        t.text :name, :null => false
        t.text :value, :null => false
        t.timestamps
      end
      add_index :contact_attributes, :contact_id
    end

    def self.down
      drop_table :contact_attributes
    end
  end
end
