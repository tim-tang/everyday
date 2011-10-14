class CreateEydIbooks < ActiveRecord::Migration
  def self.up
    create_table :eyd_ibooks do |t|
      t.string :ibook_file_name
      t.string :ibook_content_type
      t.integer :ibook_file_size
      t.datetime :ibook_updated_at
      t.string :image_url
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :eyd_ibooks
  end
end
