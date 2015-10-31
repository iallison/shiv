class CloudEnvironment < ActiveRecord::Base
  attr_accessible :container_gateway, :container_network, :container_vlan, :host_gateway, :host_gateway, :host_network, :host_vlan, :name, :overlay_gateway, :overlay_network, :overlay_vlan, :storage_gateway, :storage_network, :storage_vlan, :swift_gateway, :swift_network, :swift_vlan, :external_vip, :internal_vip, :notes 
  acts_as_taggable_on :tags
  acts_as_commentable
  has_eav_behavior
end
