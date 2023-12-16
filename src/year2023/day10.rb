module Year2023
  class Day10
    attr_reader :matrix, :min_row, :max_row, :min_col, :max_col

    def part1(input, start_pipe: nil)
      lines = input.split("\n")

      start_pipe = 'L' if start_pipe.nil?

      @matrix = SparseMatrix.new
      @min_row = 0
      @max_row = 0
      @min_col = 0
      @max_col = 0
      start_position = nil

      lines.each.with_index do |row, row_index|
        row.chars.each.with_index do |char, col_index|
          if char == 'S'
            location = Location.new(pipe: start_pipe)
            matrix[row_index, col_index] = location
            location.distance = 0
            start_position = [row_index, col_index]
          else
            location = Location.new(pipe: char)
            matrix[row_index, col_index] = location
          end
          @min_row = [min_row, row_index].min
          @max_row = [max_row, row_index].max
          @min_col = [min_col, col_index].min
          @max_col = [max_col, col_index].max
        end
      end

      # print_matrix(matrix, :pipe, min_row, max_row, min_col, max_col)

      count = 0

      row_1, col_1 = start_position[0], start_position[1]
      row_2, col_2 = row_1, col_1

      loop do
        count += 1

        next_loc_1, next_loc_2 = find_next_row_col(matrix, row_1, col_1)

        next_row_1, next_col_1 = next_loc_1
        next_row_2, next_col_2 = next_loc_2

        if !matrix[next_row_1, next_col_1].distance.nil? && !matrix[next_row_2, next_col_2].distance.nil?
          break
        elsif matrix[next_row_1, next_col_1].distance.nil?
          matrix[next_row_1, next_col_1].distance = count
          row_1, col_1 = next_row_1, next_col_1
        elsif matrix[next_row_2, next_col_2].distance.nil?
          matrix[next_row_2, next_col_2].distance = count
          row_1, col_1 = next_row_2, next_col_2
        end
        # print_matrix(matrix, :distance, min_row, max_row, min_col, max_col)
        # byebug

        next_loc_1, next_loc_2 = find_next_row_col(matrix, row_2, col_2)

        next_row_1, next_col_1 = next_loc_1
        next_row_2, next_col_2 = next_loc_2

        if !matrix[next_row_1, next_col_1].distance.nil? && !matrix[next_row_2, next_col_2].distance.nil?
          break
        elsif matrix[next_row_1, next_col_1].distance.nil?
          matrix[next_row_1, next_col_1].distance = count
          row_2, col_2 = next_row_1, next_col_1
        elsif matrix[next_row_2, next_col_2].distance.nil?
          matrix[next_row_2, next_col_2].distance = count
          row_2, col_2 = next_row_2, next_col_2
        end
        # print_matrix(matrix, :distance, min_row, max_row, min_col, max_col)
        # byebug
      end

      # print_matrix(matrix, :distance, min_row, max_row, min_col, max_col)

      count
    end

    def part2(input, start_pipe: nil)
      part1(input, start_pipe:)

      print_matrix(matrix, :pipe, min_row, max_row, min_col, max_col)
      puts
      print_matrix(matrix, :on_loop?, min_row, max_row, min_col, max_col)
    end

    private

    def find_next_row_col(matrix, row, col)
      pipe = matrix[row, col].pipe

      case pipe
      when "F"
        [
          [row, col+1],
          [row+1, col],
        ]
      when "J"
        [
          [row, col-1],
          [row-1, col],
        ]
      when "L"
        [
          [row, col+1],
          [row-1, col],
        ]
      when "7"
        [
          [row, col-1],
          [row+1, col],
        ]
      when "-"
        [
          [row, col-1],
          [row, col+1],
        ]
      when "|"
        [
          [row-1, col],
          [row+1, col],
        ]
      end
    end

    def print_matrix(matrix, property, min_row, max_row, min_col, max_col)
      for row in min_row..max_row do
        for col in min_col..max_col do
          print matrix[row, col].public_send(property) || '.'
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

  class Location
    attr_reader :pipe
    attr_accessor :distance

    def initialize(pipe:)
      @pipe = pipe
      @distance = nil
    end

    def on_loop?
      distance.nil? ? '@' : pipe
    end
  end
end
