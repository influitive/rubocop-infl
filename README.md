# Warning

Investment day "MVP" at the moment, needs test and default configuration to be
set up before releasing.

Shamelessly based on https://github.com/backus/rubocop-rspec

# Rubocop::Infl

This gem contains Influitive specific rubocop cops.

The first, `Infl/SoftLineLength` allows a more "gentle" checking of line lengths
in a ruby project.

In your `Gemfile`:

    group :development to
      gem "rubocop", require: false
      gem "rubocop-infl", require: false
    end

In your `.rubocop.yml`:

    require "rubocop-infl"
    Infl/SoftLineLength:
      Enabled: true
      SoftLimit: 80
      HardLimit: 120
      SoftAllowancePercentOfLines: 2

This would complain about *any* lines which were longer than 120 characters,
and allow up to 2% of non blank lines in a file to be longer than 80 characters
before starting to complain about them.
