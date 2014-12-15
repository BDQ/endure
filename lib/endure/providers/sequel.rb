require 'sequel'

module Endure::Providers
  class Sequel
    def initialize(config)
      @client = ::Sequel.connect(config[:connection])

      # ensure k/v colleciton exists
      if config.key? :collection
        @collection = config[:collection].to_sym
        @client.create_table(@collection) do
          String :key,   text: true
          String :value, text: true
        end
      end

      # ensure search index exists
      if config.key? :index
        @index = config[:index].to_sym
        @client.create_table(@index) do
          String :number
          String :customer_email
          Float  :total
        end
      end
    end

    # -------- Key / Value --------
    def set(key, value)
      @client[@collection].insert(key: key, value: value)
    end

    def get(key)
      result = @client[@collection].where(key: key)
      result.first[:value]
    end


    # ---------- Search -----------
    def index(key, document)
      @client[@index].insert(document)
    end

    def query(criteria)
      result = @client[@index].where(criteria)
      result.first
    end

  end
end
