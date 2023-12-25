module Year2023
  class Day17
    def part1(input)
      grid = []

      input.split("\n").each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          char
        end
        grid << line
      end

      print_grid(grid)

      0
    end

    def part2(input)
      nil
    end

    private

    def print_grid(grid)
      grid.each do |row|
        row.each do |cell|
          print cell
        end
        print "\n"
      end
      print "\n"
    end
  end
end
