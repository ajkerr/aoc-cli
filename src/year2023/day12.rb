module Year2023
  class Day12
    def part1(input)
      input.split("\n").each do |line|
        row, groups = line.split(' ')
        groups = groups.split(',').map(&:to_i)
        byebug
      end

      0
    end

    def part2(input)
      nil
    end
  end
end
