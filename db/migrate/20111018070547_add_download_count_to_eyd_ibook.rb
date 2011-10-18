class AddDownloadCountToEydIbook < ActiveRecord::Migration
  def self.up
    add_column :eyd_ibooks, :download_count, :integer, :default => 0
  end

  def self.down
    remove_column :eyd_ibooks, :download_count
  end
end
