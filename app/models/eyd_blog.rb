class EydBlog < ActiveRecord::Base
  extend FriendlyId 
  friendly_id :title, :use => :slugged
  belongs_to :eyd_user
  acts_as_taggable_on :tags
  attr_accessor :blog_tags

  validates :title, :presence => true, :uniqueness => true
#  validates :blog_tags, :presence => true
end
