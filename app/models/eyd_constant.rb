class EydConstant < ActiveRecord::Base
  belongs_to :eyd_user
  validates :category, :presence => true, :uniqueness => true
end
