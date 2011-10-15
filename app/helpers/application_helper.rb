module ApplicationHelper
  
  def available_seasons
    Season.all
  end
  
  def member_companies
    MemberCompany.all
  end
  
  def show_types
    [["Play", "Play"],
     ["Musical", "Musical"]]
  end
  
  def working_season
    Season.find(session[:working_season_id])
  end
  
  def working_season_name
    working_season.name || 'no working season'
  end
end
