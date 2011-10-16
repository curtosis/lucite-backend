class HomeController < ApplicationController
  def index
    @users = User.all
    @available_seasons = Season.all
    #session[:working_season_id] ||= Season.last.id
  end

end
