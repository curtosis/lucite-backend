class Ballot
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :secure_data, :type => String
  field :adjudicator_code, :type => String
  field :ballot_hash, :type => String
  
  embedded_in :show
  
end
