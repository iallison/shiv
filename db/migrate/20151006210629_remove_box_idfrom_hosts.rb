class RemoveBoxIdfromHosts < ActiveRecord::Migration
  def up
    remove_column :hosts, :box_id, :integer
  end

  def down
  end
end
