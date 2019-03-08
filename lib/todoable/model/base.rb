require 'active_support/time'

module Todoable
	module Model
		class Base

		def initialize(client)
			set(client)
		end

		private 
		  	def check_response (response)
		  		Error::ResponseValidator.validate(response)
		  		JSON.parse(response.body,:symbolize_names => true)
		  	end

		  	def set (client)
		  		@client = client
		  		@headers = {
		  			:Authorization => "Token token=#{@client.auth.token}",
		  			:Accept => "application/json",
		  			:'Content-Type' => 'application/json'
		  		}
		  	end

			def check_exp
				#TODO test
				if @client.auth.expires_at  < Time.now - 20.minutes
					@client.authorize(false)
					set(@client)
				end
			end		  	
		end
	end
end