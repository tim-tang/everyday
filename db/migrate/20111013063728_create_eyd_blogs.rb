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
    add_index :eyd_blogs, ["user_id"], :name=>"blog_user_id_index"
    add_index :eyd_blogs, ["constant_id"], :name=>"blog_constant_id_index"
    add_index :eyd_blogs, ["is_draft"], :name=>"blog_is_draft_index"
    add_index :eyd_blogs, ["created_at"], :name=>"blog_created_at_index"
  end

  def self.down
    drop_table :eyd_blogs
  end
end
