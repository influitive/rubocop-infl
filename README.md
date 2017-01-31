# Rubocop::Infl

This gem contains Influitive specific rubocop cops. To use them you can do this
in your `Gemfile` for a project:

    group :development to
      gem 'rubocop', require: false
      gem 'rubocop-infl', require: false
    end

And add this to your `.rubocop.yml` for the project:

    require: "rubocop-infl"

## Infl/SoftLineLength

It is considered good style to limit the length of lines in Ruby source code,
and we have found that *sometimes* there are lines which are a little longer
than our conventional limit and breaking up made the code less readable and
"greppable".  This Cop attempts to help with that situation by allowing a file
to have up to a certain percentage of the lines be longer than our "usual"
limit.

    Metrics/LineLength:
      Enabled: false

    Infl/SoftLineLength:
      Enabled: true
      SoftLimit: 80
      HardLimit: 120
      AllowedLongLinePercentage: 2

This would complain about *any* lines which were longer than 120 characters,
and allow up to 2% of lines in a file to be longer than 80 characters
before starting to complain about the lines longer that 80 characters.

# Inspiration

Shamelessly based on https://github.com/backus/rubocop-rspec

http://rubocop.readthedocs.io/en/latest/extensions/#custom-cop has more
information on custom cops.

# License

This is licensed under the [MIT License](./LICENSE.txt)
