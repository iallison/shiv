class Host < ActiveRecord::Base
  attr_accessible :ip, :kernel, :name, :operating_system, :os_release, :box_name, :box_id, :tag_list, :title
  belongs_to :box
  has_many :host_attributes
  acts_as_taggable_on :tags
  acts_as_commentable
  has_eav_behavior

end
