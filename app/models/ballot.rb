class Ballot
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :secure_data, :type => String
  field :judge_code, :type => String
  
  embedded_in :show
  
end
