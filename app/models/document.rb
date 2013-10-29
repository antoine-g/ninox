class Document < ActiveRecord::Base
  attr_accessible :desc, :title, :course_id, :user_id
  belongs_to :course
  belongs_to :user
  has_attached_file :docfile

  validates_presence_of :user
  validates_presence_of :title
end
