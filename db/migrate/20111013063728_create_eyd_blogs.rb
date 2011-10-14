class CreateEydBlogs < ActiveRecord::Migration
  def self.up
    create_table :eyd_blogs do |t|
      t.string :title
      t.string :author
      t.string :video_url
      t.text :content
      t.integer :constant_id
      t.integer :user_id
      t.boolean :is_draft

      t.timestamps
    end
  end

  def self.down
    drop_table :eyd_blogs
  end
end
