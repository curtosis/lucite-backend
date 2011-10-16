require 'yajl'

class BallotsController < ApplicationController
  
  # never submitted as forms (only API) so this isn't needed
  skip_before_filter :verify_authenticity_token
  
  # save a new rawballot
  # /api/raw_ballots/submit
  def create
    begin
      parse = Yajl::Parser.parse(request.body.read)
      raw_ballot = parse['raw_ballot']
      puts "received ballot (show title: #{raw_ballot['show_title']})"
      
      # find show
      season, show = find_and_validate_season_and_show(raw_ballot['show_title'], raw_ballot['producing_company'])
      raise "Could not locate season" if season.nil?
      raise "Could not locate show" if show.nil?
      puts "Located season (#{season.name}) and show (#{show.name})"
      
      # find judge
      # it's not (currently) fatal if we can't find the adjudicator
      adjudicator = find_and_validate_adjudicator(raw_ballot['adjudicator_company'], raw_ballot['adjudicator_number'])
      if adjudicator.nil?
        puts "Could not locate adjudicator"
      else
        "Located adjudicator (#{adjudicator.name})"
      end
      
      # build, encrypt, and save
      ballot = build_ballot(raw_ballot)
      
      # this will eventually be a receipt
      render :json => Time.now.to_f.to_json
      
    rescue Exception => e
      puts e.message
      render :json => e.message.to_json, :status => 500   
    end
  end
  
  private
    def find_and_validate_season_and_show(show_name, producing_company)
      season = Season.where("shows.name" => show_name).first
      puts "found season (#{season.name})"
      company = MemberCompany.find(producing_company)
      puts "found company (#{company.name})"
      shows = season.shows.where(:name => show_name)
      puts "there are #{shows.count} potential matches"
      show = shows.where(:member_company => company)
      puts "found show (#{show.name})"
      return season, show
    end
    
    def find_and_validate_adjudicator(adjudicator_company, adjudicator_number)
      MemberCompany.find(adjudicator_company).adjudicators.where(adjudicator_number: adjudicator_number).first
    end
    
    def build_ballot(raw_ballot)
      #currently no-op
      raw_ballot
    end
    
    def encrypt_and_save_ballot
      
    end 
  
end
