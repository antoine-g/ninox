class Course < ActiveRecord::Base
  attr_accessible :code, :name

  code_regex = /\A[a-z]{2}\d{2}\z/i

  before_validation :format_code

  validates :code, :presence => true,
                    :uniqueness =>  { :case_sensitive => false },
                    :format => { :with => code_regex }

  def format_code
    code.upcase! if code
  end
end
