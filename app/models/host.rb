class Host < ActiveRecord::Base
  attr_accessible :ip, :kernel, :name, :operating_system, :os_release, :box_name, :tag_list, :title
  belongs_to :box
  acts_as_taggable_on :tags
  acts_as_commentable
  has_eav_behavior

end
