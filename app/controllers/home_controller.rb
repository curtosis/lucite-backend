class HomeController < ApplicationController
  def index
    @users = User.all
    @current_season = "2011"
  end
end
