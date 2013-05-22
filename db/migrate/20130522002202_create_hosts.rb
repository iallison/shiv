class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :kernel
      t.string :operating_system
      t.string :os_release
      t.string :ip

      t.timestamps
    end
  end
end
