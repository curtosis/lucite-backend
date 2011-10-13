class Show
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :company, :type => String
  field :season, :type => String
  field :type, :type => String
end
