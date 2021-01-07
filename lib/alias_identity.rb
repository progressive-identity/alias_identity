require "forwardable"

require "alias_identity/version"
require "alias_identity/resources/owner.rb"
require "alias_identity/alias_configuration.rb"

module AliasIdentity
  class Error < StandardError; end

  @configuration = AliasConfiguration.setup

  class << self
    extend Forwardable

    def_delegators :@configuration, :api_key, :api_key=
  end
  # Your code goes here...
end
