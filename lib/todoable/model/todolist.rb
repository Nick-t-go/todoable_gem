require 'json'
require 'todoable/model/base'

module Todoable
	module Model
		class TodoList < Base

			def get_lists
				check_exp
		  		response = @client.class.get("/lists", :headers => @headers)
		  		check_response(response)
		  	end

		  	def get_list (list_id)
		  		check_exp
		  		response = @client.class.get("/lists/#{list_id}", :headers => @headers)
		  		check_response(response)
		  	end

		  	def post_list (todo_list)
		  		check_exp
		  		response = @client.class.post("/lists",
		  			:headers => @headers,
		  			:body => todo_list.to_json
		  		)
		  		check_response(response)
		  	end

		  	def patch_list (list_id, edited_list)
		  		#TODO responds ok if name is invalid, that's an issue
		  		check_exp
		  		response = @client.class.patch("/lists/#{list_id}",
		  			:headers => @headers,
		  			:body => edited_list.to_json
		  		)
		  		Error::ResponseValidator.validate(response)
		  	end

		  	def delete_list (list_id)
		  		check_exp
		  		response = @client.class.delete("/lists/#{list_id}",
		  			:headers => @headers
		  		)
		  		Error::ResponseValidator.validate(response)
		  	end
		end
	end
end