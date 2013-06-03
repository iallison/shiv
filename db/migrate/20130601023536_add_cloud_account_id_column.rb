class AddCloudAccountIdColumn < ActiveRecord::Migration
  def up
    change_table :cloud_users do |t|
      t.integer :cloud_accounts_id
    end
  end

  def down
    remove_column :cloud_users, :cloud_accounts_id
  end
end
