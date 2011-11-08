class EydAvatar < ActiveRecord::Base
  attr_accessible :title, :avatar, :desc, :constant_id, :user_id
  belongs_to :eyd_user
  acts_as_taggable_on :tags
  attr_accessor :title
  has_attached_file :avatar,
    :url =>"/system/pictures/:id/:style_:basename.:extension",
    :path =>":rails_root/public/system/pictures/:id/:style_:basename.:extension",
    :styles =>{:large=>"500x450>", :medium => "500x280>", :thumb =>"80x80>"}

  private
  def self.fetch_admin_avatars(user_id,page)
    paginate :conditions=> ['user_id = ?', user_id],
      :order=> 'updated_at desc',
      :page => page,
      :per_page=>20
  end

end
