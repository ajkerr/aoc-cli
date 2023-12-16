module Year2023
  class Day06
    def part1(input)
      lines = input.split("\n")

      times = lines[0].scan(/Time:\s(.*)/).first.first.strip.split(/\s+/).map(&:to_i)
      distances = lines[1].scan(/Distance:\s(.*)/).first.first.strip.split(/\s+/).map(&:to_i)

      winning_counts = []

      times.each.with_index do |time, index|
        winning_count = 0

        for charge in 0..time do
          result = charge * (time - charge)
          winning_count += 1 if result > distances[index]
        end

        winning_counts << winning_count
      end

      winning_counts.inject(&:*)
    end

    def part2(input)
      lines = input.split("\n")

      time = lines[0].scan(/Time:\s(.*)/).first.first.strip.split(/\s+/).join.to_i
      distance = lines[1].scan(/Distance:\s(.*)/).first.first.strip.split(/\s+/).join.to_i

      winning_count = 0

      for charge in 0..time do
        result = charge * (time - charge)
        winning_count += 1 if result > distance
      end

      winning_count
    end
  end
end
