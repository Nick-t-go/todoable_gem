require 'todoable/version'
require 'todoable/client'
require 'HTTParty'



module Todoable

	def self.client
	    @client ||= Todoable::Client.new
	end
 
end
