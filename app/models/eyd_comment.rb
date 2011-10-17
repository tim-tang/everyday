class EydComment < ActiveRecord::Base
  validates :name, :presence => true
end
