class User
  include Mongoid::Document
  
  # Devise modules:
  # * :database_authenticable - encrypt and store a password in the database
  # * :registerable - allows users to register for an account
  # * :recoverable - resets user password and sends reset instructions
  # :rememberable - manages setting and clearing a token cookie
  # * :trackable - tracks sign in cound, timestamps, and IP address
  # * :validatable - provides validations of emails and passwords
  # :token_authenticatable - user signs in based on a single access token
  # :encryptable - adds additional encryption options
  # :confirmable - sends emails with validation instructions
  # * :lockable - locks after a specified number of failed logins
  # * :timeoutable - expire sessions that have no activity in a certain time period
  # :omniauthable - adds OmniAuth support
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :trackable, :validatable, :lockable

  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end

