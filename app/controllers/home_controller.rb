class HomeController < ApplicationController
  def index
    @users = User.all
    @working_season = Season.last
  end

end
