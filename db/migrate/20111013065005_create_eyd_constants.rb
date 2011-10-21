class CreateEydConstants < ActiveRecord::Migration
  def self.up
    create_table :eyd_constants do |t|
      t.string :category
      t.integer :user_id

      t.timestamps
    end
    add_index :eyd_constants, ["user_id"], :name=>"constant_user_id_index"
  end

  def self.down
    drop_table :eyd_constants
  end
end
