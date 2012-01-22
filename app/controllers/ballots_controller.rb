require 'yajl'
require 'crypter'

class BallotsController < ApplicationController
  
  # never submitted as forms (only API) so this isn't needed
  skip_before_filter :verify_authenticity_token
  
  # save a new rawballot
  # /api/raw_ballots/submit
  def create
    begin
      parse = Yajl::Parser.parse(request.body.read)
      received_ballot = parse['raw_ballot']
      puts "received ballot (show title: #{received_ballot['show_title']})"
      
      # find show
      # season, show = find_and_validate_season_and_show(raw_ballot['show_title'], raw_ballot['producing_company'])
      # raise "Could not locate season" if season.nil?
      # raise "Could not locate show" if show.nil?
      # puts "Located season (#{season.name}) and show (#{show.name})"
      
      # # find judge
      # # it's not (currently) fatal if we can't find the adjudicator
      # adjudicator = find_and_validate_adjudicator(raw_ballot['adjudicator_company'], raw_ballot['adjudicator_number'])
      # if adjudicator.nil?
      #   puts "Could not locate adjudicator"
      # else
      #   "Located adjudicator (#{adjudicator.name})"
      # end
      
      # build, encrypt, and save
      ballot = build_ballot(received_ballot)
      
      adjudicator = received_ballot['adjudicator_number'] + "@" + received_ballot['adjudicator_company']
      sballot = encrypt_and_generate_ballot_record(ballot, adjudicator)
      
      puts "Ballot encrypted: adjudicator=#{sballot[:adjudicator_code]}, hash=#{sballot[:ballot_hash]}"
      #show.ballots.create(sballot)
      SecureBallot.create(sballot)

      # send the hash as a receipt for now
      render :json => sballot[:ballot_hash].to_json
      
      
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
      show = shows.detect { |s|  s.member_company == company  }
      
      puts "found show (#{show.name})"
      return season, show
    end
    
    def find_and_validate_adjudicator(adjudicator_company, adjudicator_number)
      MemberCompany.find(adjudicator_company).adjudicators.where(adjudicator_number: adjudicator_number).first
    end
    
    def build_ballot(raw_ballot)
      #currently just re-jsonifies the raw_ballot portion.
      raw_ballot.to_json
    end
    
    def encrypt_and_generate_ballot_record(ballot, adjudicator_name)
      crypter = Crypter.new
      sballot = Hash.new
      sballot[:adjudicator_code] = crypter.generate_hash(adjudicator_name + '360Q')
      sballot[:secure_data] =  crypter.encrypt_data('sparkleMotion', ballot)
      sballot[:ballot_hash] = crypter.generate_hash(ballot)
      return sballot
    end 
  
end
