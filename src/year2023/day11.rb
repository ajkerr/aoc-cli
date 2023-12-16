require 'set'

module Year2023
  class Day11
    ROW_PAD = 1_000_000

    def part1(input)
      lines = input.split("\n")

      grid = []
      galaxy = 0
      galaxies = {}

      lines.each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          if char == '#'
            galaxy +=1
            galaxies[galaxy] = [row_index, col_index]
            galaxy
          else
            char
          end
        end
        grid << line
      end

      # print_grid(grid)
      # puts

      # Expand empty rows
      replicate_empty_rows(grid, 1)
      # print_grid(grid)
      # puts

      # Expand empty columns
      grid = grid.transpose
      replicate_empty_rows(grid, 1)
      grid = grid.transpose
      # print_grid(grid)
      # puts

      grid.each.with_index do |row, row_index|
        row.each.with_index do |char, col_index|
          if char != '.'
            galaxies[char] = [row_index, col_index]
          end
        end
      end

      sum = 0

      galaxies.keys.combination(2).each do |pair|
        sum += (galaxies[pair[1]][1] - galaxies[pair[0]][1]).abs + (galaxies[pair[1]][0] - galaxies[pair[0]][0]).abs
        # puts min_path
      end

      sum
    end

    def part2(input)
      lines = input.split("\n")

      grid = []
      galaxy = 0
      galaxies = {}

      lines.each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          if char == '#'
            galaxy +=1
            galaxies[galaxy] = [row_index, col_index]
            galaxy
          else
            char
          end
        end
        grid << line
      end

      # print_grid(grid)
      # puts

      empty_rows = find_empty_rows(grid)
      empty_cols = find_empty_rows(grid.transpose)

      grid.each.with_index do |row, row_index|
        row.each.with_index do |char, col_index|
          if char != '.'
            galaxies[char] = [row_index, col_index]
          end
        end
      end

      sum = 0

      galaxies.keys.combination(2).each do |pair|
        sum += (galaxies[pair[1]][1] - galaxies[pair[0]][1]).abs + (galaxies[pair[1]][0] - galaxies[pair[0]][0]).abs

        row_range = galaxies[pair[1]][0] > galaxies[pair[0]][0] ? galaxies[pair[0]][0]..galaxies[pair[1]][0] : galaxies[pair[1]][0]..galaxies[pair[0]][0]
        empty_rows.each do |row|
          sum += (ROW_PAD-1) if row_range.cover?(row)
        end

        col_range = galaxies[pair[1]][1] > galaxies[pair[0]][1] ? galaxies[pair[0]][1]..galaxies[pair[1]][1] : galaxies[pair[1]][1]..galaxies[pair[0]][1]
        empty_cols.each do |col|
          sum += (ROW_PAD-1) if col_range.cover?(col)
        end
      end

      sum
    end

    private

    def print_grid(grid)
      grid.each do |row|
        row.each do |cell|
          print cell
        end
        print "\n"
      end
    end

    def replicate_empty_rows(grid, count)
      rows_to_replicate = []

      grid.each.with_index do |row, index|
        if row.all? { |cell| cell == '.' }
          rows_to_replicate << index
        end
      end

      rows_to_replicate.each.with_index do |row_index, i|
        count.times do
          grid.insert(row_index + i, Array.new(grid.first.length, '.'))
        end
      end
    end

    def find_empty_rows(grid)
      empty_rows = Set.new

      grid.each.with_index do |row, index|
        if row.all? { |cell| cell == '.' }
          empty_rows << index
        end
      end

      empty_rows
    end

    class Galaxy
      attr_reader :number, :location

      def initialize(number:, location:)
        @number = number
        @location = location
      end
    end
  end
end
