module Year2022
  class Day01
    def part1(input)
      calorie_counts(input).max
    end

    def part2(input)
      calorie_counts(input).sort.reverse[0..2].sum
    end

    private

    def calorie_counts(input)
      numbers = input.split("\n").map(&:to_i)
      calorie_counts = [0]

      numbers.each do |number|
        if number.zero?
          calorie_counts << 0
        else
          calorie_counts[-1] = calorie_counts[-1] + number
        end
      end

      calorie_counts
    end
  end
end
