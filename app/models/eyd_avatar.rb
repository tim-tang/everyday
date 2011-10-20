class EydAvatar < ActiveRecord::Base
  attr_accessible :title, :avatar, :desc, :constant_id, :user_id
  belongs_to :eyd_user
  acts_as_taggable_on :tags
  attr_accessor :title
  has_attached_file :avatar,
    :url =>"/system/pictures/:id/:style_:basename.:extension",
    :path =>":rails_root/public/system/pictures/:id/:style_:basename.:extension",
    :styles =>{:large=>"500x500>", :medium => "550x280>", :thumb =>"80x80>"}
end
