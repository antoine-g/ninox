class Document < ActiveRecord::Base
  attr_accessible :desc, :title
  belongs_to :course
end
