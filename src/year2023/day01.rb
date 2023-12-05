module Year2023
  INTEGERS_BY_NAME = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
  }.freeze

  class Day01
    def part1(input)
      lines = input.split("\n")

      sum = 0

      lines.each do |line|
        digits = line.scan(/\d/)
        first_digit = digits.first.to_i
        last_digit = digits.last.to_i

        calibration_value = 10 * first_digit + last_digit
        sum += calibration_value
      end

      sum
    end

    def part2(input)
      lines = input.split("\n")

      sum = 0

      lines.each do |line|
        digits = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/)

        # if line.index('oneight') != nil
        #   puts line
        #   puts digits
        #   puts
        # end

        first_digit = to_i(digits.first.first)
        last_digit = to_i(digits.last.first)

        calibration_value = 10 * first_digit + last_digit
        sum += calibration_value
      end

      sum
    end

    private

    def to_i(value)
      if Integer(value, exception: false)
        value.to_i
      else
        INTEGERS_BY_NAME[value.to_sym]
      end
    end
  end
end
