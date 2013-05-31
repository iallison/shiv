class CreateCloudUsers < ActiveRecord::Migration
  def change
    create_table :cloud_users do |t|
      t.string :name
      t.boolean :admin, :default => false
      t.integer :contact_id
      t.datetime :sla_accept_date

      t.timestamps
    end
  end
end
