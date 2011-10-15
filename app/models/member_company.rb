class MemberCompany
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :representative, :type => String
  field :code, :type => String
  
  embeds_one :physical_address, :class_name => "Address"
  embeds_one :mailing_address, :class_name => "Address"

  # can't do this because shows are embedded in a season!
  #has_many :shows

  accepts_nested_attributes_for :physical_address, :mailing_address

  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code

end


