class Endure
  autoload :QueryResult,       'endure/query_result'

  module Providers
    autoload :DynamoDB,        'endure/providers/dynamo_db'
    autoload :CloudSearch,     'endure/providers/cloud_search'
    autoload :Sequel,          'endure/providers/sequel'
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

  def query(criteria, sort={})
    result = @search.query(criteria, sort)

    # we add the store config, so the user can later choose to 'inflate' the index documents with
    # the actual key/value stored objects (as index can sometimes only be a summary of the object)
    #
    result.store = @store
    result
  end
end
