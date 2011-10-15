class Season
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes   #needed for rails date_select output
  
  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :status, :type => Symbol

  validates_presence_of :name, :start_date, :end_date
  validates_uniqueness_of :name

  attr_accessible :name, :start_date, :end_date

  embeds_many :shows
  
  def editable?
    (defined? status) and (status === :open or status === :created)
  end
  
  def self.working(session)
    find(session[:working_season_id])
  end
end
