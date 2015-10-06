class AddAdditionalTraitsToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :serial, :string
    add_column :hosts, :memory, :string
    add_column :hosts, :cloud_environment, :string
  end
end
