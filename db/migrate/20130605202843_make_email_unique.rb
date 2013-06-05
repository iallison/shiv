class MakeEmailUnique < ActiveRecord::Migration
  def up
    add_index :contacts, :email, :unique => true
  end

  def down
    remove_index :contacts, :email
  end
end
