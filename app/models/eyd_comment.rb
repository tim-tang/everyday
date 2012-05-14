class EydComment < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :eyd_blog, :foreign_key=>"blog_id"

  private
  def self.fetch_admin_comments(page)
    paginate :order=> 'updated_at desc',
      :page => page,
      :per_page=>20
  end
end
