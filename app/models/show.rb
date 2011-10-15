class Show
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  embedded_in :season

  belongs_to :member_company 
    
  field :name, :type => String
  field :type, :type => String


  validates_presence_of :name, :type
  
end
