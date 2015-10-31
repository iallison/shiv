class AddAdditionalTraitsToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :serial, :string
    add_column :hosts, :memory, :string
    add_column :hosts, :cloud_environment, :string
    add_column :hosts, :location, :string
    add_column :hosts, :role, :string
  end
end
