require 'spec_helper'

describe PagesController do
  render_views

  it "GET on '/' should route to GET 'home'" do
    { :get => "/" }.should route_to(:controller => "pages", :action => "home")
  end

  describe "GET 'home'" do
    before(:each) do
        get :home
    end

    it "should be success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "#{@app_name} | Home")
    end

    it "should contain header navbar" do
      response.should have_selector("div", :class => "navbar")
    end

    it "should contain welcome partial" do
      response.should have_selector("div", :class => "hero-unit")
    end

    it "should contain footer" do
      response.should have_selector("div", :class => "footer")
    end
  end

  describe "GET 'about'" do
    before(:each) do
        get :about
    end

    it "should be success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "#{@app_name} | About")
    end
  end

end
