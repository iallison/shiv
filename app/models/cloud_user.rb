class CloudUser < ActiveRecord::Base
  attr_accessible :admin, :name, :sla_accept_date, :contact_id
  has_one :contact
  acts_as_taggable
  acts_as_commentable
  has_eav_behavior
end
