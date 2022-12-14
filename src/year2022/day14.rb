module Year2022
  class Day14
    def part1(input)
      rows = input.split("\n").map do |row|
        row.split(" -> ").map do |coordinate|
          coordinate.split(",").map(&:to_i)
        end
      end

      matrix = SparseMatrix.new
      deepest_rock_level = -1
      minimum_column = nil
      maximum_column = nil

      rows.each do |row|
        row.each_cons(2) do |pairs|
          firsts = [pairs[0][0], pairs[1][0]]
          lasts = [pairs[0][1], pairs[1][1]]

          for i in firsts.min..firsts.max
            minimum_column = i if minimum_column.nil? || i < minimum_column
            maximum_column = i if maximum_column.nil? || i > maximum_column

            for j in lasts.min..lasts.max
              matrix[i, j] = '#'
              deepest_rock_level = j if j > deepest_rock_level
            end
          end
        end
      end

      # puts
      # print_cave(matrix, minimum_column, maximum_column, deepest_rock_level)

      sand_count = 0

      loop do
        result = drop_sand(matrix, minimum_column, maximum_column, deepest_rock_level)
        # puts
        # print_cave(matrix, minimum_column, maximum_column, deepest_rock_level)
        # byebug

        if result
          sand_count += 1
        else
          break
        end
      end

      # byebug

      sand_count
    end

    def part2(input)
      rows = input.split("\n").map do |row|
        row.split(" -> ").map do |coordinate|
          coordinate.split(",").map(&:to_i)
        end
      end

      matrix = SparseMatrix.new
      deepest_rock_level = -1
      minimum_column = nil
      maximum_column = nil

      rows.each do |row|
        row.each_cons(2) do |pairs|
          firsts = [pairs[0][0], pairs[1][0]]
          lasts = [pairs[0][1], pairs[1][1]]

          for i in firsts.min..firsts.max
            minimum_column = i if minimum_column.nil? || i < minimum_column
            maximum_column = i if maximum_column.nil? || i > maximum_column

            for j in lasts.min..lasts.max
              matrix[i, j] = '#'
              deepest_rock_level = j if j > deepest_rock_level
            end
          end
        end
      end

      # puts
      # print_cave(matrix, minimum_column, maximum_column, deepest_rock_level)

      sand_count = 0

      loop do
        result = drop_sand_part2(matrix, minimum_column, maximum_column, deepest_rock_level)
        # puts
        # print_cave(matrix, minimum_column, maximum_column, deepest_rock_level)
        # byebug

        if result
          sand_count += 1
        else
          break
        end
      end

      # byebug

      sand_count + 1
    end

    private

    def drop_sand(matrix, minimum_column, maximum_column, deepest_rock_level)
      level = 0
      column = 500

      loop do
        if matrix[column, level + 1].nil?
          level += 1
        elsif matrix[column - 1, level + 1].nil?
          level += 1
          column -= 1
        elsif matrix[column + 1, level + 1].nil?
          level += 1
          column += 1
        else
          matrix[column, level] = 'o'
          return true
        end

        return false if level > deepest_rock_level
      end
    end

    def drop_sand_part2(matrix, minimum_column, maximum_column, deepest_rock_level)
      level = 0
      column = 500
      floor_level = deepest_rock_level + 2

      loop do
        if matrix[column, level + 1].nil? && level + 1 < floor_level
          level += 1
        elsif matrix[column - 1, level + 1].nil? && level + 1 < floor_level
          level += 1
          column -= 1
        elsif matrix[column + 1, level + 1].nil? && level + 1 < floor_level
          level += 1
          column += 1
        else
          matrix[column, level] = 'o'
          return level != 0 || column != 500
        end
      end
    end

    def print_cave(matrix, minimum_column, maximum_column, deepest_rock_level)
      for i in 0..deepest_rock_level
        for j in minimum_column..maximum_column
          if matrix[j, i].nil?
            print '.'
          else
            print matrix[j, i]
          end
        end
        print "\n"
      end
    end
  end

  class SparseMatrix
    def initialize
      @hash = {}
    end

    def [](row, col)
      @hash[[row, col]]
    end

    def []=(row, col, val)
      @hash[[row, col]] = val
    end
  end
end
