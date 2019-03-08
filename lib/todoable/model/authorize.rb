

module Todoable
	module Model
	
	class Authorize
		attr_reader :token, :expires_at
		def initialize(client)
  			headers = { :Accept => 'application/json',
  					:'Content-Type'=> 'application/json'}
  		    response = client.class.post(
  		    	"/authenticate",
  		    	:basic_auth => client.configuration.basic_auth,
  		    	:headers => headers
  		    )
  		    Error::ResponseValidator.validate(response)
  		    @token = response['token']
  		    @expires_at = response['expires_at']
  		end
	end
   end
end