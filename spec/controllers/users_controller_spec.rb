require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should return http success" do
      get 'show', :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get 'show', :id => @user
      response.should have_selector(:title => "#{@app_name} | #{@user.email}")
    end

    it "should display the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

  describe "GET 'new'" do
    it "should return http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector(:title => "#{@app_name} | #{@title}")
    end
  end
end
