class Document < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_attached_file :docfile,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment :docfile,
    content_type: { content_type: [
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/epub+zip",
      "text/html",
      "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/rtf",
      "text/plain",
      "application/xhtml+xml",
      "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ] }

  validates_presence_of :user
  validates_presence_of :title

  is_impressionable :column_name => :unique_views, :unique => :session_hash, :counter_cache => true
end
