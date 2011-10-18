class AddViewCountToEydBlog < ActiveRecord::Migration
  def self.up
    add_column :eyd_blogs, :view_count, :integer,:default => 0
  end

  def self.down
    remove_column :eyd_blogs, :view_count
  end
end
