class Box < ActiveRecord::Base
  attr_accessible :location, :model, :name, :purchase_date, :serial, :vendor
  has_many :hosts
end
