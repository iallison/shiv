class CreateCloudEnvironments < ActiveRecord::Migration
  def change
    create_table :cloud_environments do |t|
      t.string :name
      t.string :host_network
      t.string :host_gateway
      t.string :host_vlan
      t.string :host_gateway
      t.string :container_network
      t.string :container_vlan
      t.string :container_gateway
      t.string :overlay_network
      t.string :overlay_vlan
      t.string :overlay_gateway
      t.string :storage_network
      t.string :storage_vlan
      t.string :storage_gateway
      t.string :swift_network
      t.string :swift_vlan
      t.string :swift_gateway

      t.timestamps
    end
  end
end
