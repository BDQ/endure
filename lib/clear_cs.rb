#!/usr/bin/env ruby
$stdout.sync = true
require 'endure'

cs = Endure::Providers::CloudSearch.new({ query_url: 'https://search-bdq-sd6zzi4irc5xmzb2isoyttfsjy.us-east-1.cloudsearch.amazonaws.com',
                                          index_url: 'https://doc-bdq-sd6zzi4irc5xmzb2isoyttfsjy.us-east-1.cloudsearch.amazonaws.com' })

res = cs.query('', '')

documents = res.documents.map {|d| { type: 'delete', id: "fake_store/#{d[:number]}" } }
puts documents

x = cs.send(:index_client).upload_documents documents: documents.to_json, content_type: 'application/json'
puts x.inspect

1
