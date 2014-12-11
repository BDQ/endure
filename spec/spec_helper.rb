require 'simplecov'
SimpleCov.start
require 'rspec'
require 'endure'

RSpec.configure do |config|
  config.mock_framework = :rspec
end
