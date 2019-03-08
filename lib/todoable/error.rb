module Todoable
	module Error

		class ResponseValidator
	      # If the request is not successful, raise an appropriate Todoable::Error
	     
	      def self.validate(response)
	        return true if successful_response?(response)
	        raise error_from_response(response)
	      end

	      private

	      def self.successful_response?(response)
	        # Check if the status is in the range of non-error status codes
	        (200..399).include?(response.code)
	      end

	      def self.error_from_response(response)
	      	case response.code
	      	when 500
	      		raise Error::ServiceError.new('Internal Server Error')
	      	when 401
	      		raise Error::Unauthorized
	      	else
	      		body = JSON(response.body).map{|key,value| "#{key}: #{value}"}
	      		raise Error::ServiceError.new(body.join(','))
	      	end
	      end
	    
	  	end

		class Base < StandardError
	      def initialize(msg)
	        super(msg)
	      end
		end

		class Unauthorized < Base
			def initialize(msg = "Unauthorized, check credentials")
	    		super
			end
		end


		class MissingCredentials < Base
			def initialize(msg = "You're missing an API key")
	    		super
			end
		end

		class ServiceError < Base
			def initialize(msg = "The data you passed has problems")
	    		super
			end
		end

		class AlreadyConfigured < Base
			def initialize(msg = "API already configured")
	    		super
			end
		end

	end
end