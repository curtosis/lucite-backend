class Adjudicator
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :company, :type => String
end
