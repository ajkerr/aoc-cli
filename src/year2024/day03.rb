module Year2024
  class Day03
    def part1(input)
      sum = 0

      input.scan(/mul\((\d+),(\d+)\)/).each do |match|
        sum += match[0].to_i * match[1].to_i
      end

      sum
    end

    def part2(input)
      sum = 0

      do_multiplies = true

      input.scan(/mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))/).each do |match|
        if match[2] == 'do()'
          do_multiplies = true
        elsif match[3] == "don't()"
          do_multiplies = false
        else
          sum += match[0].to_i * match[1].to_i if do_multiplies
        end
      end

      sum
    end
  end
end
