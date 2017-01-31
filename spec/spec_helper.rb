require 'rubocop'
require 'rubocop/rspec/support'
require 'pry'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.disable_monkey_patching!

  config.warnings = true

  config.order = :random

  Kernel.srand config.seed
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

def default_config_file_name
  File.join(File.dirname(__FILE__), '..', 'config', 'default.yml')
end

def default_config
  RuboCop::ConfigLoader.load_file default_config_file_name
end

require 'rubocop-infl'
