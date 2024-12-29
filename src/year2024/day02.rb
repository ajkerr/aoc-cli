module Year2024
  class Day02
    def part1(input)
      safe = 0

      lines = input.split("\n").map(&:split)
      lines = lines.map do |row|
        row = row.map(&:to_i)
      end

      differences = []
      lines.each do |line|
        row_difference = []
        line.each_cons(2).each do |first, second|
          row_difference << second - first
        end
        differences << row_difference

        next if !row_difference.all? { |n| n >= 0 } && !row_difference.all? { |n| n <= 0}
        next if row_difference.any? { |difference| !(1..3).cover?(difference.abs) }
        safe += 1
      end

      safe
    end

    def part2(input)
      safe = 0

      lines = input.split("\n").map(&:split)
      lines = lines.map do |row|
        row = row.map(&:to_i)
      end

      lines.each do |line|
        if row_safe?(line)
          safe += 1
          next
        end

        line.each_index do |i|
          subset_line = line.dup
          subset_line.delete_at(i)
          if row_safe?(subset_line)
            safe += 1
            break
          end
        end
      end

      safe
    end

    private

    def row_safe?(row)
      differences = []
      row.each_cons(2).each do |first, second|
        differences << second - first
      end

      return false if !differences.all? { |n| n >= 0 } && !differences.all? { |n| n <= 0}
      return false if differences.any? { |difference| !(1..3).cover?(difference.abs) }
      true
    end
  end
end
