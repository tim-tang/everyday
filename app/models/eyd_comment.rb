class EydComment < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :eyd_blog, :foreign_key=>"blog_id"

  private
  def self.fetch_admin_comments(page)
    paginate :order=> 'updated_at desc',
      :page => page,
      :per_page=>20
  end

  def self.fetch_guestbk_comments(page, is_guestbk)
    paginate :conditions => ['is_guestbook=?',is_guestbk],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>20
  end

  def self.fetch_blog_comments(blog_id, page)
    paginate :conditions => ['blog_id=?',blog_id],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>10
  end
end
