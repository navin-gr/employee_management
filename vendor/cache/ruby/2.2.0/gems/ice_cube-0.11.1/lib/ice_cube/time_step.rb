module IceCube
  class TimeStep
    SECS   = 1
    MINS   = 60
    HOURS  = MINS * 60
    DAYS   = HOURS * 24
    WEEKS  = DAYS * 7
    MONTHS = {
      1  => [ 28,  29,  30,  31].map { |m| m * DAYS },
      2  => [ 59,  60,  61,  62].map { |m| m * DAYS },
      3  => [ 89,  90,  91,  92].map { |m| m * DAYS },
      4  => [120, 121, 122, 123].map { |m| m * DAYS },
      5  => [150, 151, 152, 153].map { |m| m * DAYS },
      6  => [181, 182, 183, 184].map { |m| m * DAYS },
      7  => [212, 213, 214, 215].map { |m| m * DAYS },
      8  => [242, 243, 244, 245].map { |m| m * DAYS },
      9  => [273, 274, 275, 276].map { |m| m * DAYS },
      10 => [303, 304, 305, 306].map { |m| m * DAYS },
      11 => [334, 335, 336, 337].map { |m| m * DAYS },
      12 => [365, 366]          .map { |m| m * DAYS }
    }
    YEARS = [365, 366]

    def next(base, validations)
    end

    def prev(base, validations)
    end
  end
end
