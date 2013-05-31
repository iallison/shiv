class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone
  belongs_to :cloud_user
end
