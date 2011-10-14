class EydIbook < ActiveRecord::Base
  attr_accessible :title, :ibook, :image_url, :desc, :user_id
  belongs_to :eyd_user
  acts_as_taggable_on :tags
  attr_accessor :title
  has_attached_file :ibook,
    :url =>"/system/ibooks/:id/:style_:basename.:extension",
    :path =>":rails_root/public/system/ibooks/:id/:style_:basename.:extension",
end
