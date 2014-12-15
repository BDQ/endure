require 'spec_helper'

describe Endure::QueryResult do
  let(:store) { Endure::Providers::DynamoDB.new({region: 'us-east-1',
                                                 collection: 'bdq_orders',
                                                 aws_key:    ENV['AWS_KEY'],
                                                 aws_secret: ENV['AWS_SECRET'] }) }

  subject do
    qr = described_class.new
    qr.store = store
    qr
  end

  it 'should inflate objects when requested' do
    expect(subject).to receive(:documents).and_return([ {key: 'abc'} , {key: 'def'}])
    objects = subject.objects

    expect(objects.size).to eq 2
    expect(objects.sort).to eq %w{someothervalue somevalue}
  end
end
