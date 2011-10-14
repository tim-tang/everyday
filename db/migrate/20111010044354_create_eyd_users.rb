class CreateEydUsers < ActiveRecord::Migration
  def self.up
    create_table :eyd_users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :eyd_users
  end
end
