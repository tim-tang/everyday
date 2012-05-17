class EydBlog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
  belongs_to :eyd_user, :foreign_key => "user_id"
  belongs_to :eyd_constant, :foreign_key=>"constant_id"
  has_many :eyd_comments, :foreign_key=>"blog_id"
  acts_as_taggable_on :tags
  attr_accessor :blog_tags

  validates :title, :presence => true, :uniqueness => true
  #  validates :blog_tags, :presence => true
  searchable do
    text :title, :boost =>5
    text :content
  end

  private
  def self.fetch_admin_blogs(user_id,page,isdraft)
    paginate :conditions=> ['user_id = ? and is_draft=?', user_id, isdraft],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>28
  end

  def self.fetch_archival_list(user_id)
      EydBlog.select('year(created_at) as year, month(created_at) as month, count(id) as count').where(:user_id=>user_id).group('year(created_at),month(created_at)').order('year(created_at),month(created_at) desc')
  end

  def self.ws_fetch_blogs(user_id,dt,isdraft)
      EydBlog.where('user_id=? and is_draft=? and created_at < ?',user_id,isdraft,dt).order('created_at desc').limit(8)
  end

  def self.ws_sync_count(id)
    @blog = EydBlog.find(id)
    @blog.view_count+=1
    @blog.update_attribute("view_count",@blog.view_count)
  end

  def self.ws_next_blog(user_id, blog_id)
      EydBlog.where('user_id=? and id < ?', user_id, blog_id).order('id desc').limit(1)
  end

  def self.ws_hot_blogs(user_id)
      EydBlog.where('user_id=? and is_draft=?',user_id, false).order('view_count desc').limit(10)
  end

  def self.ws_fetch_by_category(user_id, categoryId, dt)
      EydBlog.where('user_id=? and constant_id=? and is_draft=? and created_at < ?',user_id,categoryId ,false,dt).order('created_at desc').limit(10)
  end

  def self.tech_ws_blog_size(user_id, categoryId)
      EydBlog.where('user_id=? and constant_id=? and is_draft=?',user_id,categoryId ,false).order('created_at desc')
  end

  def self.tech_ws_blogs(user_id,dt,isdraft)
      EydBlog.where('user_id=? and is_draft=? and created_at < ?',user_id,isdraft,dt).order('created_at desc').limit(4)
  end

  def self.tech_ws_category(user_id, categoryId, page)
    paginate :conditions=> ['user_id = ? and is_draft=? and constant_id=?', user_id, false, categoryId],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>3
  end



end
