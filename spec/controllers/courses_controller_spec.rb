require 'spec_helper'

describe CoursesController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @course = FactoryGirl.create(:course)

      @courses = [@course]
      30.times do
        @courses << FactoryGirl.create(:course, :code => FactoryGirl.generate(:code))
      end
    end

    it "should return http success" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "#{@app_name} | #{@title}")
    end

    it "should have 1 element for each user" do
      get index
      @courses.each do |course|
        response.should have_selector("td", :content => course.code)
      end
    end
    
    it "should paginate courses" do
      get :index
      response.should have_selector("nav.pagination")
      response.should have_selector("a", :href => "/courses?page=2", :content => "2")
      response.should have_selector("a", :href => "/courses?page=2", :content => "Next ")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @course = FactoryGirl.create(:course)
    end

    it "should return http success" do
      get 'show', :id => @course
      response.should be_success
    end

    it "should have the right title" do
      get 'show', :id => @course
      response.should have_selector("title", :content => "#{@app_name} | #{@title}")
    end

    it "should display the right course" do
      get :show, :id => @course
      assigns(:course).should == @course
    end
  end

  describe "GET 'new'" do
    it "should return http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "#{@app_name} | #{@title}")
    end
  end
end
