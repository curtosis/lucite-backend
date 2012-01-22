require 'crypter'
require 'yajl'

class SecureBallotsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@ballots = SecureBallot.find(:all).map do |ballot|
			ballot_for_display(ballot)

		end

	end

	private

		def ballot_for_display(secure_ballot)
			crypter = Crypter.new
			clear_ballot = crypter.decrypt_string('sparkleMotion', secure_ballot.secure_data)
#			calc_hash = crypter.generate_hash(clear_ballot)
			ballot = Yajl::Parser.parse(clear_ballot)
			{ 
				:show_title => 	ballot['show_title'],
				:adjudicator => ballot['adjudicator_number'] + ' @ ' + ballot['adjudicator_company'],
				:date_viewed => ballot['date_viewed'],
#				:hash => "#{secure_ballot.ballot_hash}",
#				:calc_hash => calc_hash
			}
		end

end