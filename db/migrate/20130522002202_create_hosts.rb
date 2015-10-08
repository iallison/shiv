class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :kernel
      t.string :operating_system
      t.string :os_release
      t.string :ip
      t.string :nic1_macaddress
      t.string :ipmi_macaddress
      t.string :ipmi_ipaddress
      t.timestamps
    end
  end
end
