require 'todoable/version'
require 'todoable/food/food'
require 'todoable/client'
require 'HTTParty'



module Todoable

	def self.client
	    @client ||= Todoable::Client.new
	end
  # class API
  # 	include HTTParty
  # 	base_uri 'http://todoable.teachable.tech/api'
  # 	@@token
  # 	@@expires_at

  # 	class << self
  # 		def token
  # 			@@token
  # 		end
  # 	end

  # 	def self.working 
  # 		"this is working"
  # 	end

  # 	def self.authenticate(username:, password:)
  # 		auth = {:username => username, :password => password}
  # 		headers = { :Accept => 'application/json',
  # 					:'Content-Type'=> 'application/json'}
  # 		response = post("/authenticate", :basic_auth => auth, :headers => headers)
  # 		case response.code
  # 			when 200
  # 				@@token = response['token']
  # 				@@expires_at = response['expires_at']
  # 				true
  # 			else
  # 				false
  # 		end 
  # 	end

  # 	def self.get_lists
  # 		puts @@token
  # 		headers = {
  # 			:Authorization => "Token token=#{token}"self,
  # 			:Accept => "application/json",
  # 			:'Content-Type' => 'application/json'
  # 		}
  # 		response = get("/lists", :headers => headers)
  # 		puts response
  # 		puts response.code
  # 		case response.code
  # 			when 200
  # 				response
  # 			else
  # 				false
  # 		end
  # 	end
  # end
end
