require 'spec_helper'

describe Document do
  before :each do
    @attr = { :title => "Document title", :desc => "Document desc" }
    @doc = Document.new(@attr)
  end

  it "should have a title attribute" do
    @doc.should respond_to(:title)
  end

  it "should have a desc attribute" do
    @doc.should respond_to(:desc)
  end
end
