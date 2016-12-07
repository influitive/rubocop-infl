require "pathname"
require "yaml"

require "rubocop"

require "rubocop/infl"
require "rubocop/infl/version"
require "rubocop/infl/inject"

RuboCop::Infl::Inject.defaults!

require "rubocop/cop/infl/soft_line_length"
