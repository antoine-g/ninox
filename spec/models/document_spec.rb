require 'spec_helper'

describe Document do
  before :each do
    @user = FactoryGirl.create(:user)
    @course = FactoryGirl.create(:course)
    @attr = { :title => "Document title", :desc => "Document desc", :user_id => @user.id, :course_id => @course.id }
    @doc = FactoryGirl.create(:document)
  end

  it "should have a title attribute" do
    @doc.should respond_to(:title)
  end

  it "should have a desc attribute" do
    @doc.should respond_to(:desc)
  end

  it "should have a docfile attribute" do
    @doc.should respond_to(:docfile)
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

  describe "validations" do
    describe "should fail if" do
      it "no user associated" do
        @document = Document.new(@attr.merge({ :user_id => nil }))
        @document.should_not be_valid
      end

      it "no docfile associated" do
        @document = Document.new(@attr)
        @document.should_not be_valid
      end
    end
  end
end
