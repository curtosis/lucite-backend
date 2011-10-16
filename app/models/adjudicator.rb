class Adjudicator
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :email, :type => String
  field :adjudicator_number, :type => String
  
  belongs_to :member_company
  
  validates_presence_of :name, :email, :adjudicator_number, :member_company
  
end
