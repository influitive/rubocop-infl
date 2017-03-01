module RuboCop
  module Cop
    module Infl
      # Checks forgivingly for line lengths
      class SoftLineLength < Cop
        HARD_MSG = 'Line exceeds hard length limit. [%d/%d]'.freeze
        SOFT_MSG = 'Line exceeds soft length limit. [%d/%d]'.freeze

        # Naive way of checking if lines are rubocop directives is to compare
        # them against this regex. It's possible that they might be in a string
        # which extends across many lines, we can address that when it becomes
        # a problem!
        DIRECTIVE_REGEX = /^\s*#\s*rubocop:(?:en|dis)able\s+\S/

        include RuboCop::Cop::ConfigurableEnforcedStyle

        def investigate(processed_source)
          stats = calculate_stats(processed_source)
          soft_credit =
            (stats.size * soft_allowance_percent_of_lines / 100.0).round

          stats.each do |check, index, length|
            soft_credit = report(soft_credit, check, index, length)
          end
        end

        private

        def calculate_stats(processed_source)
          processed_source
            .lines
            .select { |line| keep?(line) }
            .each_with_index
            .map { |line, index| check_line(line, index) }
            .compact
        end

        def check_line(line, index)
          case line.length
          when 0                         then nil
          when ->(l) { l <= soft_limit } then [:ok, nil, nil]
          when ->(l) { l <= hard_limit } then [:soft, index, line.length]
          else                                [:hard, index, line.length]
          end
        end

        def keep?(line)
          return true unless ignore_cop_directives?

          DIRECTIVE_REGEX !~ line
        end

        def report(soft_credit, check, index, length)
          case check
          when :soft
            soft_credit -= 1
            soft_offense(processed_source, index, length) if soft_credit < 0
          when :hard
            hard_offense(processed_source, index, length)
          end

          soft_credit
        end

        def soft_offense(processed_source, index, length)
          offense(processed_source, SOFT_MSG, index, length, soft_limit)
        end

        def hard_offense(processed_source, index, length)
          offense(processed_source, HARD_MSG, index, length, hard_limit)
        end

        def offense(processed_source, template, index, length, limit)
          loc = source_range(processed_source.buffer, index + 1, 0...length)
          msg = format(template, length, limit)
          add_offense(nil, loc, msg)
        end

        def soft_limit
          cop_config['SoftLimit']
        end

        def hard_limit
          cop_config['HardLimit']
        end

        def soft_allowance_percent_of_lines
          cop_config['AllowedLongLinePercentage']
        end

        def ignore_cop_directives?
          cop_config['IgnoreCopDirectives']
        end
      end
    end
  end
end
