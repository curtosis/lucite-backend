class HomeController < ApplicationController
  def index
    @users = User.all
    @available_seasons = Season.all
    @working_season = session[:working_season] ||= Season.last
  end

end
