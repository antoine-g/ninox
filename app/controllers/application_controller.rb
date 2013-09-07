class ApplicationController < ActionController::Base
  protect_from_forgery

  
  before_filter :app_name

  def app_name
    @app_name = "Ninox"
  end
end
