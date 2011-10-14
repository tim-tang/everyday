class CreateEydAvatars < ActiveRecord::Migration
  def self.up
    create_table :eyd_avatars do |t|
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.text :desc
      t.integer :constant_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :eyd_avatars
  end
end
