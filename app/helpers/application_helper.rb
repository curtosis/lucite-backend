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
  
  def adjudicator_numbers
    [["Judge #1", "1"],
     ["Judge #2", "2"],
     ["Judge #3", "3"],
     ["Judge #4", "4"],
     ["Judge #5", "5"],
     ["Alternate Judge", "A"],
     ["Inactive", "I"]]
  end
  
  def working_season
    Season.find(session[:working_season_id])
  end
  
  def working_season_name
    begin
      working_season.name 
    rescue
      'working season not set'
    end
  end
end
