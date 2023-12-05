module Year2023
  class Day03
    def part1(input)
      lines = input.split("\n")

      matrix = SparseMatrix.new
      min_row = 0
      max_row = 0
      min_col = 0
      max_col = 0

      lines.each.with_index do |row, row_index|
        row.chars.each.with_index do |char, col_index|
          matrix[row_index, col_index] = char
          min_row = [min_row, row_index].min
          max_row = [max_row, row_index].max
          min_col = [min_col, col_index].min
          max_col = [max_col, col_index].max
        end
      end

      # print_matrix(matrix, min_row, max_row, min_col, max_col)

      numbers_with_adjacent_symbol = []

      lines.each.with_index do |row, row_index|
        row.scan(/\d+/) do |number|
          numbers_with_adjacent_symbol << number.to_i if adjacent_to_symbol?(matrix, number, row_index, $~.offset(0)[0])
        end
      end

      numbers_with_adjacent_symbol.sum
    end

    def part2(input)
      lines = input.split("\n")

      matrix = SparseMatrix.new
      number_matrix = SparseMatrix.new
      min_row = 0
      max_row = 0
      min_col = 0
      max_col = 0

      gear_locations = []

      lines.each.with_index do |row, row_index|
        row.chars.each.with_index do |char, col_index|
          matrix[row_index, col_index] = char
          min_row = [min_row, row_index].min
          max_row = [max_row, row_index].max
          min_col = [min_col, col_index].min
          max_col = [max_col, col_index].max

          if char == '*'
            gear_locations << [row_index, col_index]
          end
        end

      end

      lines.each.with_index do |row, row_index|
        row.scan(/\d+/) do |number|
          number_index = $~.offset(0)[0]
          # puts "#{number}, #{number_index}"
          for j in number_index..(number_index+number.length-1) do
            number_matrix[row_index, j] = number.to_i
          end
        end
      end

      # puts number_matrix.to_s
      # print_matrix(matrix, min_row, max_row, min_col, max_col)

      sum = 0

      gear_locations.each do |gear_location|
        numbers = numbers_adjacent_to_gear(number_matrix, gear_location[0], gear_location[1])
        if numbers.length == 2
          sum += numbers.inject(:*)
        end
      end

      sum
    end

    private

    def adjacent_to_symbol?(matrix, number, row_index, col_index)
      for j in (col_index-1)..(col_index + number.length) do
        return true if symbol?(matrix[row_index-1, j])
        return true if symbol?(matrix[row_index+1, j])
      end
      return true if symbol?(matrix[row_index, col_index-1])
      return true if symbol?(matrix[row_index, col_index+number.length])
      false
    end

    def symbol?(char)
      !char.nil? && char != '.' && !char.match(/[0-9]/)
    end

    def numbers_adjacent_to_gear(number_matrix, row_index, col_index)
      numbers = []

      previous_was_number = false
      for j in (col_index-1)..(col_index + 1) do
        number = number_matrix[row_index-1, j]
        if number.nil?
          previous_was_number = false
        else
          numbers << number unless previous_was_number
          previous_was_number = true
        end
      end

      previous_was_number = false
      for j in (col_index-1)..(col_index + 1) do
        number = number_matrix[row_index+1, j]
        if number.nil?
          previous_was_number = false
        else
          numbers << number unless previous_was_number
          previous_was_number = true
        end
      end

      numbers << number_matrix[row_index, col_index-1] unless number_matrix[row_index, col_index-1].nil?
      numbers << number_matrix[row_index, col_index+1] unless number_matrix[row_index, col_index+1].nil?

      numbers
    end

    def print_matrix(matrix, min_row, max_row, min_col, max_col)
      for row in min_row..max_row do
        for col in min_col..max_col do
          print matrix[row, col]
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

    def to_s
      puts @hash
    end
  end
end
