require 'spec_helper'

describe DocumentsController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @doc = FactoryGirl.create(:document)

      @documents = [@document]
      30.times do
        @documents << FactoryGirl.create(:document)
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

    it "should have 1 element for each document" do
      get :index
      @documents.each do |document|
        response.should have_selector("td", :content => document.title)
      end
    end
    
    it "should paginate documents" do
      get :index
      response.should have_selector("nav.pagination")
      response.should have_selector("a", :href => "/documents?page=2", :content => "2")
      response.should have_selector("a", :href => "/documents?page=2", :content => "Next ")
    end
  end
end
