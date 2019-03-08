require 'todoable/configuration'
require 'todoable/error'
require 'todoable/model/authorize'
require 'todoable/model/todolist'
require 'todoable/model/item'
require 'HTTParty'


module Todoable
	class Client
		attr_reader :configuration, :auth
		include HTTParty
  		base_uri 'http://todoable.teachable.tech/api'

  		MODEL_CLASSES = [ Model::TodoList, Model::Item]

		def initialize(options = nil)
	      @configuration = nil
	      #define_request_methods
	      unless options.nil?
	        @configuration = Configuration.new(options)
	        check_credentials
	      end
		end

		def check_credentials
		  if configuration.nil? || !configuration.valid?
		    @configuration = nil
		    raise Error::MissingCredentials
		  else
		    # Freeze the config so it cannot be modified 
		    @configuration.freeze
		    authorize(true)
		  end
		end

		def authorize(init = false)
			@auth = Model::Authorize.new(self)
			define_request_methods if init
		end

		def configure (options)
	      raise Error::AlreadyConfigured unless @configuration.nil?
	      @configuration = Configuration.new(options)
	      check_credentials
		end

		private

		# This goes through each endpoint class and creates singletone methods
	    def define_request_methods
	      MODEL_CLASSES.each do |request_class|
	        endpoint_instance = request_class.new(self)
	        create_methods_from_instance(endpoint_instance)
	      end
	    end

	    # Loop through all of the endpoint instances' public singleton methods to
	    # add the method to client
	    def create_methods_from_instance(instance)
	      instance.public_methods(false).each do |method_name|
	        add_method(instance, method_name)
	      end
	    end

	    # Define the method on the client and send it to the endpoint instance
	    # with the args passed in
	    def add_method(instance, method_name)
	      define_singleton_method(method_name) do |*args|
	        instance.public_send(method_name, *args)
	      end
		end

	end
end