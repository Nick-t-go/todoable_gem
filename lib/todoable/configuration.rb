module Todoable
  class Configuration
    AUTH_KEYS = [:username, :password]
    attr_accessor *AUTH_KEYS

    # Creates the configuration
    # @param [Hash] hash containing configuration parameters and their values
    # @return [Configuration] a new configuration with the values from the
    #   config_hash set
    def initialize(config_hash = nil)
      if config_hash.is_a?(Hash)
        config_hash.each do |config_name, config_value|
          self.send("#{config_name}=", config_value)
        end
      end
    end

    def basic_auth
      {username: @username, password:@password }
    end

    def valid?
      AUTH_KEYS.none?{ |key| send(key).nil? || send(key).empty? }
    end
  end
end