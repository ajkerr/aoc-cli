module Year2022
  class Day04
    def part1(input)
      rows = input.split("\n").map do |row|
        row.split(",").map do |pair|
          pair = pair.split("-").map(&:to_i)
          range = (pair.first)..(pair.last)
          range.to_a
        end
      end

      count = 0

      rows.each do |row|
        if (row.first - row.last).empty? || (row.last - row.first).empty?
          count += 1
        end
      end

      count
    end

    def part2(input)
      rows = input.split("\n").map do |row|
        row.split(",").map do |pair|
          pair = pair.split("-").map(&:to_i)
          range = (pair.first)..(pair.last)
          range.to_a
        end
      end

      count = 0

      rows.each do |row|
        if row.first.intersect?(row.last)
          count += 1
        end
      end

      count
    end
  end
end
