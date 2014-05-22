class Document < ActiveRecord::Base
  attr_accessible :desc, :title, :course_id, :user_id, :docfile
  belongs_to :course
  belongs_to :user
  has_attached_file :docfile,
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_presence_of :user
  validates_presence_of :title
end
