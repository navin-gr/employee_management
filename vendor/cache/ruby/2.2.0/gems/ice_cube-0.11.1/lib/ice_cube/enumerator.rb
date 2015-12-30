module IceCube
  class Enumerator < ::Enumerator

    def initialize(schedule, from_time, to_time)
      @schedule  = schedule
      @from_time = TimeUtil.ensure_time(from_time)
      @to_time   = TimeUtil.ensure_time(to_time)
      align_start_time
      @cursor = @from_time
    end

    def each
      while res = self.find_next && @to_time.nil? || res <= @to_time
        yield Occurrence.new(res, res + schedule.duration)
      end
      raise StopIteration
    end

    def find_next
      loop do
        min_time = recurrence_rules.reduce(nil) do |min_time, rule|
          catch :limit do
            new_time = rule.next_time(time, schedule, min_time || @to_time)
            [min_time, new_time].compact.min
          end
        end
        break nil unless min_time
        @cursor = min_time + 1
        next if exception_time?(min_time)
        break min_time
      end
    end

    private

    def align_start_time
      if @from_time <= schedule.start_time || full_required?
        @from_time = schedule.start_time
      else
        @from_time += @schedule.start_time.subsec - @from_time.subsec rescue 0
      end
    end

    # Return a boolean indicating if any rule needs to be run from the start of time
    def full_required?
      recurrence_rules.any?(&:full_required?) ||
      exception_rules.any?(&:full_required?)
    end

    def exception_rules
      schedule.instance_variable_get(:@all_exception_rules)
    end

    def recurrence_rules
      @recurrence_rules ||= if recurrence_rules.empty?
        [SingleOccurrenceRule.new(schedule.start_time)].concat schedule.instance_variable_get(:@all_recurrence_rules)
      else
        schedule.instance_variable_get(:@all_recurrence_rules)
      end
    end

  end
end
