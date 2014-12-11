class Endure
  module Providers
    autoload :DynamoDB,      'endure/providers/dynamo_db'
    autoload :CloudSearch,   'endure/providers/cloud_search'
  end

  attr_accessor :store, :search

  def set(key, value, summary)
    #add to k/y
    @store.set(key, value)

    # add to search service for indexing
    if summary
      @search.index(key, summary)
    end
  end

  def get(key)
    @store.get(key)
  end

  def query(criteria)
    @search.query(criteria)
  end
end
