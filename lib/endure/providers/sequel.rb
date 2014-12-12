require 'sequel'

module Endure::Providers
  class Sequel
    def initialize(config)
      @collection = config[:collection].to_sym
      @client = ::Sequel.connect(config[:connection])

      # ensure colleciton exists
      @client.create_table(@collection) do char(50)
        String :key,   text: true
        String :value, text: true
      end
    end

    def set(key, value)
      @client[@collection].insert(key: key, value: value)
    end

    def get(key)
      result = @client[@collection].where(key: key)
      result.first[:value]
    end

  end
end
