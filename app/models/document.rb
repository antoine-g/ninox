class Document < ActiveRecord::Base
  attr_accessible :desc, :title, :course_id, :user_id, :docfile, :unique_views
  belongs_to :course
  belongs_to :user
  has_attached_file :docfile,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_presence_of :user
  validates_presence_of :title

  is_impressionable :column_name => :unique_views, :unique => :session_hash, :counter_cache => true
end
