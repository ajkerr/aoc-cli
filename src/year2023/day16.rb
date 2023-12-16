module Year2023
  class Day16
    def part1(input)
      grid = []

      input.split("\n").each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          char
        end
        grid << line
      end

      beams = []
      beams << Beam.new(row: 0, column: 0, direction: :E)

      solve(grid, beams)
    end

    def part2(input)
      grid = []

      input.split("\n").each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          char
        end
        grid << line
      end

      candidates = []

      grid.each.with_index do |row, row_index|
        candidates << Beam.new(row: row_index, column: 0, direction: :E)
        candidates << Beam.new(row: row_index, column: row.size - 1, direction: :W)
      end

      grid.first.each.with_index do |_, column_index|
        candidates << Beam.new(row: 0, column: column_index, direction: :S)
        candidates << Beam.new(row: grid.size - 1, column: column_index, direction: :N)
      end

      candidates.map do |candidate|
        solve(grid, [candidate])
      end.max
    end

    private

    def solve(grid, beams)
      energized = grid.map { |line| line.map { {} } }

      until beams.empty?
        new_beams = []

        beams.each do |beam|
          row = beam.row
          column = beam.column
          direction = beam.direction

          next if energized[row][column][direction]

          energized[row][column][direction] = true

          case direction
          when :N
            case grid[row][column]
            when '.', '|'
              new_beams << Beam.new(row: row - 1, column:, direction:)
            when '\\'
              new_beams << Beam.new(row:, column: column - 1, direction: :W)
            when '/'
              new_beams << Beam.new(row:, column: column + 1, direction: :E)
            when '-'
              new_beams << Beam.new(row:, column: column - 1, direction: :W)
              new_beams << Beam.new(row:, column: column + 1, direction: :E)
            end
          when :E
            case grid[row][column]
            when '.', '-'
              new_beams << Beam.new(row:, column: column + 1, direction:)
            when '\\'
              new_beams << Beam.new(row: row + 1, column:, direction: :S)
            when '/'
              new_beams << Beam.new(row: row - 1, column:, direction: :N)
            when '|'
              new_beams << Beam.new(row: row - 1, column:, direction: :N)
              new_beams << Beam.new(row: row + 1, column:, direction: :S)
            end
          when :S
            case grid[row][column]
            when '.', '|'
              new_beams << Beam.new(row: row + 1, column:, direction:)
            when '\\'
              new_beams << Beam.new(row:, column: column + 1, direction: :E)
            when '/'
              new_beams << Beam.new(row:, column: column - 1, direction: :W)
            when '-'
              new_beams << Beam.new(row:, column: column - 1, direction: :W)
              new_beams << Beam.new(row:, column: column + 1, direction: :E)
            end
          when :W
            case grid[row][column]
            when '.', '-'
              new_beams << Beam.new(row:, column: column - 1, direction:)
            when '\\'
              new_beams << Beam.new(row: row - 1, column:, direction: :N)
            when '/'
              new_beams << Beam.new(row: row + 1, column:, direction: :S)
            when '|'
              new_beams << Beam.new(row: row + 1, column:, direction: :S)
              new_beams << Beam.new(row: row - 1, column:, direction: :N)
            end
          end
        end

        # byebug
        beams = new_beams.reject { |beam| beam.out_of_bounds(grid) }
      end

      # print_grid(grid)
      # print_grid(energized_locations)

      sum = 0

      energized.each do |row|
        row.each do |map|
          sum += 1 unless map.empty?
        end
      end

      sum
    end

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

  class Beam
    attr_accessor :row, :column, :direction

    def initialize(row:, column:, direction:)
      @row = row
      @column = column
      @direction = direction
    end

    def out_of_bounds(grid)
      row < 0 || row >= grid.length || column < 0 || column >= grid.first.length
    end
  end
end
