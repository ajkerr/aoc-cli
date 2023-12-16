module Year2023
  class Day09
    def part1(input)
      lines = input.split("\n")

      sum = 0

      lines.each do |line|
        line = line.split(' ').map(&:to_i)
        differences = [line]
        done = false

        until done do
          next_difference = differences.last.each_cons(2).map { |a,b| b-a }
          differences << next_difference
          done = next_difference.all?(&:zero?)
        end

        next_value = nil

        differences.reverse!
        differences.each.with_index do |difference, index|
          if index == 0
            difference << 0
          else
            difference << difference.last + differences[index-1].last
          end
        end

        next_value = differences.last.last
        sum += next_value
      end

      sum
    end

    def part2(input)
      lines = input.split("\n")

      sum = 0

      lines.each do |line|
        line = line.split(' ').map(&:to_i)
        differences = [line]
        done = false

        until done do
          next_difference = differences.last.each_cons(2).map { |a,b| b-a }
          differences << next_difference
          done = next_difference.all?(&:zero?)
        end

        next_value = nil

        differences.reverse!
        differences.each.with_index do |difference, index|
          if index == 0
            difference.unshift(0)
          else
            difference.unshift(difference.first - differences[index-1].first)
          end
        end

        next_value = differences.last.first
        sum += next_value
      end

      sum
    end
  end
end
