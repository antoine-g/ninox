class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  
  before_action :app_name

  def app_name
    @app_name = "Ninox"
  end
end
