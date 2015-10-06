class AddNicTraitsToHosts < ActiveRecord::Migration
  def up
    remove_column :hosts, :macaddress_nic1, :string
    add_column :hosts, :nic1_macaddress, :string
    add_column :hosts, :ipmi_macaddress, :string
    add_column :hosts, :ipmi_ipaddress, :string
  end
end
