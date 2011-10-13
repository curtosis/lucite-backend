class Season
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes   #needed for rails date_select output
  
  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :locked, :type => Boolean
  field :tabulated, :type => Boolean
  field :closed, :type => Boolean

  validates_presence_of :name, :start_date, :end_date
  validates_uniqueness_of :name

  attr_accessible :name, :start_date, :end_date
end
