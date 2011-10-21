class CreateEydComments < ActiveRecord::Migration
  def self.up
    create_table :eyd_comments do |t|
      t.integer :parent_id
      t.integer :blog_id
      t.integer :book_id
      t.string :name
      t.string :email
      t.text :content
      t.boolean :is_guestbook

      t.timestamps
    end
    add_index :eyd_comments, ["blog_id"], :name=>"comment_blog_id_index"
    add_index :eyd_comments, ["is_guestbook"], :name=>"comment_is_guestbook_index"
    add_index :eyd_comments, ["updated_at"], :name=>"comment_created_at_index"
  end

  def self.down
    drop_table :eyd_comments
  end
end
