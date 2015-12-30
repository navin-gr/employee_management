module IceCube
  class HashInput

    class Mash
      def initialize(hash)
        @hash = hash
      end

      # Fetch values indifferently by symbol or string key without symbolizing
      # arbitrary string input
      #
      def [](key)
        @hash.fetch(key) do |key|
          str_key = key.to_s
          @hash.each_pair.detect do |sym_key, value|
            return value if sym_key.to_s == str_key
          end
        end
      end
    end

    def initialize(hash)
      @input = Mash.new(hash)
    end

    def [](key)
      @input[key]
    end

    def to_rule
      return nil unless rule_class
      rule = rule_class.new(interval, week_start)
      rule.until(limit_time) if limit_time
      rule.count(limit_count) if limit_count
      validations.each do |validation, args|
        rule.send(validation, *args)
      end
    end

    def rule_class
      return @rule_class if @rule_class
      match = @input[:rule_type].match(/::(\w+Rule)$/)
      @rule_class = IceCube.const_get(match[1]) if match
    end

    def interval
      @input[:interval] || 1
    end

    def week_start
      @input[:week_start] || :sunday
    end

    def limit_time
      @limit_time ||= TimeUtil.deserialize_time(@input[:until])
    end

    def limit_count
      @input[:count]
    end

    def validations
      input_validations = Mash.new(@input[:validations] || {})
      ValidatedRule::VALIDATION_ORDER.each_with_object({}) do |key, output_validations|
        args = input_validations[key]
        output_validations[key] = Array(args) if args
      end
    end

  end
end
