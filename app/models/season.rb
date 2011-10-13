class Season
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :start, :type => Date
  field :end, :type => Date
  field :locked, :type => Boolean
  field :tabulated, :type => Boolean
  field :closed, :type => Boolean
end
