require 'spec_helper'

describe Course do
  before :each do
    @attr = { :name => "Course name", :code => "AA00" }
    @course = Course.new(@attr)
  end

  it "should have a name attribute" do
    @course.should respond_to(:name)
  end

  it "should have a code attribute" do
    @course.should respond_to(:code)
  end

  describe "code validation" do
    it "should require a code" do
      no_code_course = Course.new(@attr.merge(:code => ""))
      no_code_course.should_not be_valid
    end

    it "should refuse invalid code" do
      codes = %w[abc12 ab123 12ab]
      codes.each do |code|
        invalid_code_course = Course.new(@attr.merge(:code => code))
        invalid_code_course.should_not be_valid
      end
    end

    it "should accept valid code" do
      codes = %w[AA00 ab12 Ab12]
      codes.each do |code|
        valid_code_course = Course.new(@attr.merge(:code => code))
        valid_code_course.should be_valid
      end
    end

    it "should reject an existing code" do
      Course.create!(@attr)
      course_with_duplicate_code = Course.new(@attr)
      course_with_duplicate_code.should_not be_valid
    end

    it "should upcase the code" do
      down_code_course = Course.create(@attr.merge(:code => "aa12"))
      down_code_course.code.should == "AA12"
    end
  end
end
