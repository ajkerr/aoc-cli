module Year2022
  class Day25
    def part1(input)
      total = input.split("\n").map do |number|
        snafu_to_decimal(number)
      end.inject(&:+)

      decimal_to_snafu(total)
    end

    def part2(input)
      nil
    end

    private

    def snafu_to_decimal(number)
      total = 0

      number.chars.reverse.each.with_index do |digit, index|
        decimal_digit = case digit
        when "2", "1", "0"
          digit.to_i
        when "-"
          -1
        when "="
          -2
        end

        total += 5.pow(index) * decimal_digit
      end

      total
    end

    def decimal_to_snafu(number)
      exp = 0
      while 5.pow(exp) <= number do
        exp += 1
      end

      exp -= 1

      snafu = []
      exp.downto(0) do |i|
        cur = number / 5.pow(i)
        snafu.push(cur)
        number = number % 5.pow(i)
      end

      (snafu.size - 1).downto(1) do |i|
        if snafu[i] == 3
          snafu[i] = '='
          snafu[i - 1] += 1
        elsif snafu[i] == 4
          snafu[i] = '-'
          snafu[i - 1] += 1
        elsif snafu[i] == 5
          snafu[i] = 0
          snafu[i - 1] += 1
        end
      end

      snafu.join
    end
  end
end
