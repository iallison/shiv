class CloudAccount < ActiveRecord::Base
  attr_accessible :charge_index, :customer_type, :name, :organization
  has_many :cloud_users
  acts_as_taggable
  acts_as_commentable
end
