require 'spec_helper'

module Endure::Providers
  describe CloudSearch do
    subject { described_class.new({ query_url: 'https://search-large-1-ozzavfou4ii3pmcw2f55c6pefy.us-east-1.cloudsearch.amazonaws.com',
                                    index_url: 'https://doc-large-1-ozzavfou4ii3pmcw2f55c6pefy.us-east-1.cloudsearch.amazonaws.com' }) }

    let(:document) { { key: 'R1234567', email: 'spree@example.com', total: 99.99 } }


    it 'should allow indexing & searching' do
      subject.index(document[:key], document)

      result = subject.query({key: 'R1234567'}, {})

      expect(result.documents.first[:key]).to eq 'R1234567'
    end
  end
end
