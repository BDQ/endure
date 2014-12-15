require 'aws-sdk-core'

module Endure::Providers
  class DynamoDB
    def initialize(config)
      @collection = config[:collection]
      Aws.config[:dynamodb] = { region: config['region'] || 'us-east-1' }

      if config.key?(:aws_key) && config.key?(:aws_secret)
        Aws.config[:credentials] = Aws::Credentials.new(config[:aws_key],
                                                        config[:aws_secret])
      end

      @client = Aws::DynamoDB::Client.new
    end

    def set(key, value)
      @client.put_item(table_name: @collection, item: { key: key, created_at: (Time.now.to_f * 1000).to_i,  value: value })
    rescue Aws::DynamoDB::Errors::ResourceNotFoundException
      create_table(@collection)

      #todo: check table is actually created
      sleep 10
      retry
    end

    def get(key)
      @client.get_item(table_name: @collection, key: { key: key }).item['value']
    end

    def multi_get(keys)
      @client.batch_get_item(
        request_items: {
          @collection.to_s => {
            keys: keys.map { |k| { key: k } }
          }
        }
      ).responses[@collection].map { |doc| doc['value'] }
    end

    def query
      raise NotImplementedError, 'DynamoDB does not support querying'
    end

    private

    def create_table(table_name)
      @client.create_table(
        table_name: table_name,
        attribute_definitions: [
          { attribute_name: 'key', attribute_type: 'S' }
        ],
        key_schema: [
          { attribute_name: 'key', key_type: 'HASH' }
        ],
        provisioned_throughput: {read_capacity_units: 1, write_capacity_units: 1}
      )
    end
  end
end
