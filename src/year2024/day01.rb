module Year2024
  class Day01
    def part1(input)
      column1 = []
      column2 = []

      lines = input.split("\n")
      lines.each do |line|
        numbers = line.split
        column1 << numbers.first.to_i
        column2 << numbers.last.to_i
      end

      column1.sort!
      column2.sort!

      distance = 0

      column1.each.with_index do |number, i|
        distance += (number - column2[i]).abs
      end

      distance
    end

    def part2(input)
      column1 = []
      column2 = []

      lines = input.split("\n")
      lines.each do |line|
        numbers = line.split
        column1 << numbers.first.to_i
        column2 << numbers.last.to_i
      end

      similarity = 0

      column1.each do |number|
        similarity += number * column2.count(number)
      end

      similarity
    end
  end
end
