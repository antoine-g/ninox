class Document < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_attached_file :docfile,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_presence_of :user
  validates_presence_of :title

  is_impressionable :column_name => :unique_views, :unique => :session_hash, :counter_cache => true
end
