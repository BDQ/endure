require 'spec_helper'

module Endure::Providers
  describe Sequel do
    subject { described_class.new({connection: 'sqlite:/',    # sqlite in memory
                                   collection: 'orders',      # k/v table
                                   index:      'orders_index' # search table
                                  }) }

    let(:document) { { number: 'R1234567', customer_email: 'spree@example.com', total: 99.99 } }

    it 'should set and get key/values' do
      subject.set('abc', 'somevalue')
      document = subject.get('abc')
      expect(document).to eq 'somevalue'
    end

    it 'should allow indexing & searching' do
      subject.index(document[:number], document)

      #TODO: return a proper dataset here
      expect(subject.query({number: 'R1234567'})[:number]).to eq 'R1234567'
    end
  end
end
