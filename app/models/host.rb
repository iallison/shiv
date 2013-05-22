class Host < ActiveRecord::Base
  attr_accessible :ip, :kernel, :name, :operating_system, :os_release, :box_id
  belongs_to :box
end
