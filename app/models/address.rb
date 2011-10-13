class Address
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :street_address, :type => String
  field :city, :type => String
  field :state, :type => String
  field :zip, :type => String
  
  embedded_in :member_company, :inverse_of => :mailing_address
  embedded_in :member_company, :inverse_of => :physical_address
end
