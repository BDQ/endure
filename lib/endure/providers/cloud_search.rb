require 'aws-sdk-core'

module Endure::Providers
  class CloudSearch
    def initialize(config)
      @index_url = config[:index_url]
      @query_url = config[:query_url]
    end

    def index(key, document)

      documents = [
        {
          type: 'add',
          id: key,
          fields: document
        }
      ]

      index_client.upload_documents documents: documents.to_json, content_type: 'application/json'
    end

    def query(criteria)
      structure = '(and '

      criteria.each do |field, value|
        structure << "(term field=#{field} '#{value}') "
      end

      structure << ')'

      hits = []
      query_client.search(
          query: structure,
          query_parser: "structured"
      ).each_page do |page|
        hits << page.hits
      end

      #TODO: return a proper dataset here
      hits
    end

    private

    def index_client
      @index_client ||= Aws::CloudSearchDomain::Client.new(endpoint: @index_url)
    end

    def query_client
      @query_client ||= Aws::CloudSearchDomain::Client.new(endpoint: @query_url)
    end

  end
end
