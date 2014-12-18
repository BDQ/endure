module Endure::Providers
  class Hash
    def initialize(config)
      @store = {}
    end

    # -------- Key / Value --------
    def set(key, value)
      @store[key] = value
    end

    def get(key)
      @store[key]
    end

    # ---------- Search -----------
    def index(key, document)
      # TODO
    end

    def query(criteria)
      # TODO
    end
  end
end