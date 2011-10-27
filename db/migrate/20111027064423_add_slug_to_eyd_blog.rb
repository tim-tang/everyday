class AddSlugToEydBlog < ActiveRecord::Migration
  def self.up
    add_column :eyd_blogs, :slug, :string
    add_index :eyd_blogs, :slug, :unique=> true
  end

  def self.down
    remove_column :eyd_blogs, :slug
  end
end
