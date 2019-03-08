require 'json'
require 'todoable/model/base'

module Todoable
	module Model
		class Item < Base

		  	def post_item (list_id, item)
		  		check_exp
		  		response = @client.class.post("/lists/#{list_id}/items",
		  			:headers => @headers,
		  			:body => item.to_json
		  		)
		  		check_response(response)
		  	end

		  	def delete_item (list_id, item_id)
		  		check_exp
		  		response = @client.class.delete("/lists/#{list_id}/items/#{item_id}",
		  			:headers => @headers
		  		)
		  		Error::ResponseValidator.validate(response)
		  	end

		  	def finish_item (list_id, item_id)
		  		check_exp
		  		response = @client.class.put("/lists/#{list_id}/items/#{item_id}/finish",
		  			:headers => @headers
		  		)
		  		Error::ResponseValidator.validate(response)
		  	end

		end
	end
end