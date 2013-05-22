class Host < ActiveRecord::Base
  attr_accessible :ip, :kernel, :name, :operating_system, :os_release, :box_id, :tag_list
  belongs_to :box
  acts_as_taggable_on :tags
end
