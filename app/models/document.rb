class Document < ActiveRecord::Base
  attr_accessible :desc, :title, :course_id
  belongs_to :course
end
