class Box < ActiveRecord::Base
  attr_accessible :location, :model, :name, :purchase_date, :serial, :vendor, :tag_list
  has_many :hosts
  acts_as_taggable_on :tags
  acts_as_commentable
end
