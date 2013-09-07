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

  describe "POST 'create'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "with invalid params" do
      it "invalid email should redirect to 'users/new'" do
        invalid_email_user = FactoryGirl.create(:user, :email => "invalidemail")
        post :create, :params => invalid_email_user
        response.should redirect_to :action => "new"
      end
    end
  end
end
