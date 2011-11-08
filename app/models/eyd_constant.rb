class EydConstant < ActiveRecord::Base
  belongs_to :eyd_user
  has_many :eyd_blogs, :foreign_key => "constant_id"
  validates :category, :presence => true, :uniqueness => true

  private
  def self.fetch_admin_constants(user_id,page)
    paginate :conditions=> ['user_id = ?', user_id],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>20
  end
end
