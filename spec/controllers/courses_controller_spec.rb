require 'spec_helper'

describe CoursesController do


  describe "GET 'index'" do
    it "should return http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should return http success" do
      get 'show', :id => @course
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should return http success" do
      get 'new'
      response.should be_success
    end
  end
end
