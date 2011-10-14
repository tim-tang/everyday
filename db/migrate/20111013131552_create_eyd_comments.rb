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
  end

  def self.down
    drop_table :eyd_comments
  end
end
