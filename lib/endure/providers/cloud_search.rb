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

    def query(criteria, sort)
      if criteria.empty?
        # no criteria, so we presume we just wanna get the latest (sorted) records
        #
        structure = 'matchall'
      else
        structure = '(and '

        criteria.each do |field, value|
          structure << "(term field=#{field} '#{value}') "
        end

        structure << ')'
      end

      search_opts = {
          query: structure,
          query_parser: 'structured'
      }

      unless sort.empty?
        search_opts[:sort] = sort.to_a.join(' ')
      end

      result = Endure::QueryResult.new

      query_client.search(search_opts).each_page do |page|
        result.matching = page.hits.found
        result.returned = page.hits.hit.count

        page.hits.hit.each do |hit|
          result.documents << hit.fields.map { |k,v| {k.to_sym => v.first} }.reduce(:merge)
        end
      end

      #TODO: return a proper dataset here
      result
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
