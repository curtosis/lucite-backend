class ApplicationController < ActionController::Base
  protect_from_forgery
  include FrontendHelpers::Html5Helper

  before_filter :_reload_libs, :if => :_reload_libs?
  
  def _reload_libs
    RELOAD_LIBS.each do |lib|
      require_dependency lib
    end
  end
  
  def _reload_libs?
    defined? RELOAD_LIBS
  end
    
end
