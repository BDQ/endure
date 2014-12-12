require 'spec_helper'

module Endure::Providers
  describe Sequel do
    subject { described_class.new({connection: 'sqlite:/', #sqlite in memory
                                   collection: 'bdq_orders'}) }

    it 'should set and get key/values' do
      subject.set('abc', 'somevalue')
      document = subject.get('abc')
      expect(document).to eq 'somevalue'
    end
  end
end
