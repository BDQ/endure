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
    def index(key, value, terms)
      # TODO
    end

    def query(criteria)
      # TODO
    end
  end
end