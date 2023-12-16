module Year2023
  class Day13
    def part1(input)
      grids = input.split(/\n{2,}/).map do |lines|
        lines.split("\n").map { |line| line.split('') }
      end

      # grids.each { |grid| print_grid(grid) }
      horizontal_lines = []
      vertical_lines = []

      grids.each do |grid|
        reflection_row = find_reflection_line(grid)
        horizontal_lines << reflection_row unless reflection_row.nil?
        # puts "Grid #{index + 1} rows: #{reflection_rows}"
        reflection_column = find_reflection_line(grid.transpose)
        vertical_lines << reflection_column unless reflection_column.nil?
        # puts "Grid #{index + 1} columns: #{reflection_columns}"
      end

      horizontal_lines.map { |row| row * 100 }.sum + vertical_lines.sum
    end

    def part2(input)
      grids = input.split(/\n{2,}/).map do |lines|
        lines.split("\n").map { |line| line.split('') }
      end

      # grids.each { |grid| print_grid(grid) }
      horizontal_lines = []
      vertical_lines = []

      grids.each do |grid|
        reflection_row = find_reflection_line(grid)
        reflection_column = find_reflection_line(grid.transpose)
        # horizontal_lines += reflection_rows
        # puts "Grid #{index + 1} rows: #{reflection_rows}"
        # vertical_lines += reflection_columns
        # puts "Grid #{index + 1} columns: #{reflection_columns}"

        found_alt = false

        grid.each.with_index do |row, row_index|
          break if found_alt

          row.each.with_index do |cell, col_index|
            new_grid = Marshal.load(Marshal.dump(grid))
            new_grid[row_index][col_index] = cell == '#' ? '.' : '#'

            # print_grid(new_grid)
            # byebug
            alt_reflection_row = find_reflection_line(new_grid)
            alt_reflection_column = find_reflection_line(new_grid.transpose)

            if !alt_reflection_row.nil? && alt_reflection_row != reflection_row
              horizontal_lines << alt_reflection_row
              found_alt = true
              break
            end

            if !alt_reflection_column.nil? && alt_reflection_column != reflection_column
              vertical_lines << alt_reflection_column
              found_alt = true
              break
            end
          end
        end
      end

      horizontal_lines.map { |row| row * 100 }.sum + vertical_lines.sum
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

    def find_reflection_line(grid)
      reflection_line = nil

      grid.each.with_index do |row, index|
        if index + 1 < grid.length && row == grid[index+1]
          if validate_reflection(grid, index, index+1)
            reflection_line = index + 1
          end
        end
      end

      reflection_line
    end

    def validate_reflection(grid, i1, i2)
      valid = true
      while i1 >= 0 && i2 < grid.length do
        if grid[i1] != grid[i2]
          valid = false
          break
        end
        i1 -= 1
        i2 += 1
      end
      valid
    end
  end
end
