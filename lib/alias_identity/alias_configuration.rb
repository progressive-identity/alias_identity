module AliasIdentity
  class AliasConfiguration
    attr_accessor :api_key

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end
  end
end
