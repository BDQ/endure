require 'aws-sdk-core'

module Endure::Providers
  class DynamoDB
    def initialize(config)
      @collection = config[:collection]
      @hash_key_attribute = config[:hash_key_attribute]

      Aws.config[:dynamodb] = { region: config['region'] || 'us-east-1' }

      if config.key?(:aws_key) && config.key?(:aws_secret)
        Aws.config[:credentials] = Aws::Credentials.new(config[:aws_key],
                                                        config[:aws_secret])
      end

      @client = Aws::DynamoDB::Client.new
    end

    def set(key, value)
      if @hash_key_attribute
        item_hash = {
          @hash_key_attribute => value[@hash_key_attribute.to_sym],
          object_id: key,
          object_value: value,
          updated_at: Time.now.to_i
        }
      else
        item_hash = {
          object_key: key,
          object_value: value,
          updated_at: Time.now.to_i
        }
      end

      @client.put_item(
        table_name: @collection,
        item: item_hash
      )
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
  end
end
