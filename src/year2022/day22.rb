module Year2022
  class Day22
    def part1(input)
      lines = input.split("\n")
      instructions = lines.last
      lines.pop
      lines.pop

      col_limits = {}
      row_limits = Hash.new([1_000_000_000, -1])
      matrix = SparseMatrix.new

      lines.each.with_index do |line, row|
        col_limits[row + 1] = [line.index(/(\.|#)/) + 1, line.size]

        line.chars.each.with_index do |char, col|
          next if char == ' '
          row_limit = row_limits[col + 1]
          new_row_limit = [[row_limit[0], row + 1].min, [row_limit[1], row + 1].max]
          row_limits[col + 1] = new_row_limit
          matrix[row + 1, col + 1] = char
        end
      end

      moves = []
      instructions.scan(/(\d+)(L|R)?/).each do |match|
        moves << [match[0].to_i, match[1]]
      end

      person = Person.new(matrix, row_limits, col_limits, 1, col_limits[1][0], :right)

      moves.each do |move|
        person.do_move(move)
      end

      1000 * person.row + 4 * person.col + Person::DIRECTIONS[person.direction]
    end

    def part2(input)
      nil
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

  class Person
    DIRECTIONS = {
      right: 0,
      down: 1,
      left: 2,
      up: 3
    }.freeze

    TRANSFORMATIONS = {
      right: [0, 1],
      down: [1, 0],
      left: [0, -1],
      up: [-1, 0]
    }.freeze

    attr_reader :row, :col, :direction

    def initialize(matrix, row_limits, col_limits, row, col, direction)
      @matrix = matrix
      @row_limits = row_limits
      @col_limits = col_limits
      @row = row
      @col = col
      @direction = direction
    end

    def do_move(move)
      count, rotation = move
      transformation = TRANSFORMATIONS[@direction]

      possible_row = row
      possible_col = col

      count.times do
        possible_row = possible_row + transformation[0]
        possible_col = possible_col + transformation[1]

        if possible_col != col
          col_limit = @col_limits[possible_row]
          possible_col = col_limit[1] if possible_col < col_limit[0]
          possible_col = col_limit[0] if possible_col > col_limit[1]
        elsif possible_row != row
          row_limit = @row_limits[possible_col]
          possible_row = row_limit[1] if possible_row < row_limit[0]
          possible_row = row_limit[0] if possible_row > row_limit[1]
        end

        if @matrix[possible_row, possible_col] == '.'
          @row = possible_row
          @col = possible_col
        else
          break
        end
      end

      case rotation
      when 'L'
        @direction = DIRECTIONS.key((DIRECTIONS[direction] - 1) % 4)
      when 'R'
        @direction = DIRECTIONS.key((DIRECTIONS[direction] + 1) % 4)
      end
    end
  end
end
