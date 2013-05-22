class AddIdsToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :box_id, :integer
  end
end
