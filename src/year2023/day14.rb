module Year2023
  class Day14
    DIRECTIONS = [:N, :W, :S, :E].freeze

    def part1(input)
      grid = []

      input.split("\n").each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          char
        end
        grid << line
      end

      # print_grid(grid)

      grid.each.with_index do |row, row_index|
        next if row_index == 0

        row.each.with_index do |cell, col_index|
          if cell == 'O'
            roll_rock_north(grid, row_index, col_index)
          end
        end
      end

      # print_grid(grid)
      sum = 0

      grid.each.with_index do |row, row_index|
        sum += row.count { |cell| cell == 'O' } * (grid.length - row_index)
      end

      sum
    end

    def part2(input)
      grid = []

      input.split("\n").each.with_index do |line, row_index|
        line = line.split('').map.with_index do |char, col_index|
          char
        end
        grid << line
      end

      # print_grid(grid)

      cycles = 1_000_000_000

      1.upto(cycles) do |cycle|
        # puts cycle
        DIRECTIONS.each do |direction|
          case direction
          when :N
            grid.each.with_index do |row, row_index|
              next if row_index == 0

              row.each.with_index do |cell, col_index|
                if cell == 'O'
                  roll_rock_north(grid, row_index, col_index)
                end
              end
            end
          when :W
            grid.each.with_index do |row, row_index|
              next if row_index == 0

              row.each.with_index do |cell, col_index|
                if cell == 'O'
                  roll_rock_north(grid, row_index, col_index)
                end
              end
            end
          when :S
            grid.each.with_index do |row, row_index|
              next if row_index == 0

              row.each.with_index do |cell, col_index|
                if cell == 'O'
                  roll_rock_north(grid, row_index, col_index)
                end
              end
            end
          when :E
            grid.each.with_index do |row, row_index|
              next if row_index == 0

              row.each.with_index do |cell, col_index|
                if cell == 'O'
                  roll_rock_north(grid, row_index, col_index)
                end
              end
            end
          end
        end
      end

      # print_grid(grid)
      sum = 0

      grid.each.with_index do |row, row_index|
        sum += row.count { |cell| cell == 'O' } * (grid.length - row_index)
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
      print "\n"
    end

    def roll_rock_north(grid, row_index, col_index)
      (row_index - 1).downto(0) do |potential_row_index|
        break if grid[potential_row_index][col_index] != '.'
        grid[potential_row_index][col_index] = 'O'
        grid[potential_row_index+1][col_index] = '.'
        # print_grid(grid)
        # byebug
      end
    end
  end
end
