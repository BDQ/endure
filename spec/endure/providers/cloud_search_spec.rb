require 'spec_helper'

module Endure
  module Providers
    describe CloudSearch do
      subject { described_class.new({ query_url: 'https://search-bdq-sd6zzi4irc5xmzb2isoyttfsjy.us-east-1.cloudsearch.amazonaws.com',
                                      index_url: 'https://doc-bdq-sd6zzi4irc5xmzb2isoyttfsjy.us-east-1.cloudsearch.amazonaws.com' }) }

      let(:document) { { number: 'R1234567', customer_email: 'spree@example.com', total: 99.99 } }


      it 'should allow indexing & searching' do
        subject.index(document[:number], document)

        #TODO: return a proper dataset here
        expect(subject.query({number: 'R1234567'}).first.hit.first.id).to eq 'R1234567'
      end
    end
  end
end
