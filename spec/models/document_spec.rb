require 'spec_helper'

describe Document do
  before :each do
    @course = FactoryGirl.create(:course)
    @attr = { :title => "Document title", :desc => "Document desc" }
    @doc = Document.new(@attr)
  end

  it "should have a title attribute" do
    @doc.should respond_to(:title)
  end

  it "should have a desc attribute" do
    @doc.should respond_to(:desc)
  end

  describe "association to course" do
    before(:each) do
      @document = @course.documents.create(@attr)
    end

    it "should have a course attribute" do
      @document.should respond_to(:course)
    end

    it "should have the right course associated" do
      @document.course_id.should == @course.id
      @document.course.should == @course
    end
  end
end
