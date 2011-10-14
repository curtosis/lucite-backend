module ApplicationHelper
  
  def available_seasons
    Season.all
  end
  
  def member_companies
    MemberCompany.all
  end
  
end
