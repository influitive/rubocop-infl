# rubocop:disable Metrics/BlockLength

require 'spec_helper'

RSpec.describe RuboCop::Cop::Infl::SoftLineLength do
  let(:config) do
    RuboCop::Config.new(
      default_config
      .for_cop(described_class.cop_name)
      .merge(described_class.cop_name => cop_config)
    )
  end

  subject(:cop) { described_class.new(config) }

  # NOTE: The tests here all use even numbers of lines so that 50% works out
  # as a nice integral value. That makes it easier to figure out expected
  # results in your head without worrying about rounding.

  percentage = 50 # `let` doesn't seem to interpolate in the `it` strings...
  let(:hard_limit) { 30 }
  let(:soft_limit) { 20 }
  let(:cop_config) do
    {
      'HardLimit' => hard_limit,
      'SoftLimit' => soft_limit,
      'AllowedLongLinePercentage' => percentage
    }
  end

  let(:short_line) { '#' * soft_limit }
  let(:long_line) { '#' * hard_limit }
  let(:over_long_line) { '#' * (hard_limit + 1) }

  it 'finds line longer than `HardLimit`' do
    inspect_source(cop, over_long_line)
    expect(cop.offenses.size).to eq(1)
    expect(cop.offenses.first.message).to start_with('Line exceeds hard ')
  end

  context 'with lines between hard and soft limits' do
    it "allows low percentage (1/4 < #{percentage}%)" do
      source = [short_line, short_line, long_line, short_line]

      inspect_source(cop, source)
      expect(cop.offenses).to be_empty
    end

    it "traps high percentage (3/4 > #{percentage}%)" do
      source = [long_line, long_line, short_line, long_line]

      inspect_source(cop, source)
      expect(cop.offenses.size).to eq(1)
      expect(cop.offenses.first.message).to start_with('Line exceeds soft ')
    end

    it 'reports the right number of exceeding soft limit lines' do
      num_long = 7
      num_short = 3

      source = [long_line] * num_long + [short_line] * num_short
      inspect_source(cop, source)

      expected = num_long - (num_long + num_short) * percentage / 100.0
      expect(cop.offenses.size).to eq(expected)
    end
  end
end
