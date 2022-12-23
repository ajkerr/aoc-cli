module Year2022
  class Day23
    RULESETS = [
      {
        check: [:north, :northeast, :northwest],
        move: :north
      },
      {
        check: [:south, :southeast, :southwest],
        move: :south
      },
      {
        check: [:west, :northwest, :southwest],
        move: :west
      },
      {
        check: [:east, :northeast, :southeast],
        move: :east
      },
    ]

    def part1(input)
      elves = []
      min_row = 0
      max_row = 0
      min_col = 0
      max_col = 0
      matrix = SparseMatrix.new

      input.split("\n").each.with_index do |row, row_index|
        row.chars.each.with_index do |char, col_index|
          next if char == "."
          elf = Elf.new(matrix, row_index, col_index)
          elves << elf
          matrix[row_index, col_index] = elf
          min_row = [min_row, row_index].min
          max_row = [max_row, row_index].max
          min_col = [min_col, col_index].min
          max_col = [max_col, col_index].max
        end
      end

      print_matrix(matrix, min_row, max_row, min_col, max_col)

      starting_ruleset = 0

      for rounds in 1..10 do
        proposed_moves = {}

        elves.each do |elf|
          proposed_move = elf.propose_move(starting_ruleset)
          next if proposed_move.nil?

          proposed_moves[proposed_move] = [] if proposed_moves[proposed_move].nil?
          proposed_moves[proposed_move] << elf
        end

        proposed_moves = proposed_moves.select { |key, value| value.size == 1 }

        proposed_moves.each do |new_location, elves|
          elf = elves.first
          elf.move(new_location[0], new_location[1])
          min_row = [min_row, new_location[0]].min
          max_row = [max_row, new_location[0]].max
          min_col = [min_col, new_location[1]].min
          max_col = [max_col, new_location[1]].max
        end

        starting_ruleset = (starting_ruleset + 1) % RULESETS.size
      end

      print_matrix(matrix, min_row, max_row, min_col, max_col)

      (max_row - min_row + 1) * (max_col - min_col + 1) - elves.size
    end

    def part2(input)
      elves = []
      min_row = 0
      max_row = 0
      min_col = 0
      max_col = 0
      matrix = SparseMatrix.new

      input.split("\n").each.with_index do |row, row_index|
        row.chars.each.with_index do |char, col_index|
          next if char == "."
          elf = Elf.new(matrix, row_index, col_index)
          elves << elf
          matrix[row_index, col_index] = elf
          min_row = [min_row, row_index].min
          max_row = [max_row, row_index].max
          min_col = [min_col, col_index].min
          max_col = [max_col, col_index].max
        end
      end

      print_matrix(matrix, min_row, max_row, min_col, max_col)

      starting_ruleset = 0
      answer = 0

      for round in 1..1000 do
        proposed_moves = {}

        elves.each do |elf|
          proposed_move = elf.propose_move(starting_ruleset)
          next if proposed_move.nil?

          proposed_moves[proposed_move] = [] if proposed_moves[proposed_move].nil?
          proposed_moves[proposed_move] << elf
        end

        proposed_moves = proposed_moves.select { |key, value| value.size == 1 }
        if proposed_moves.empty?
          answer = round
          break
        end

        proposed_moves.each do |new_location, elves|
          elf = elves.first
          elf.move(new_location[0], new_location[1])
          min_row = [min_row, new_location[0]].min
          max_row = [max_row, new_location[0]].max
          min_col = [min_col, new_location[1]].min
          max_col = [max_col, new_location[1]].max
        end

        starting_ruleset = (starting_ruleset + 1) % RULESETS.size
      end

      print_matrix(matrix, min_row, max_row, min_col, max_col)

      round
    end

    private

    def print_matrix(matrix, min_row, max_row, min_col, max_col)
      puts
      for row in min_row..max_row do
        for col in min_col..max_col do
          print case matrix[row, col]
          when nil
            '.'
          else
            '#'
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

  class Elf
    TRANSFORMATIONS = {
      north: [-1, 0],
      south: [1, 0],
      east: [0, 1],
      west: [0, -1],
      northeast: [-1, 1],
      northwest: [-1, -1],
      southeast: [1, 1],
      southwest: [1, -1],
    }.freeze

    attr_reader :row, :col

    def initialize(matrix, row, col)
      @matrix = matrix
      @row = row
      @col = col
    end

    def propose_move(starting_ruleset)
      neighbour_info = {}

      TRANSFORMATIONS.each do |key, value|
        location = [row + value[0], col + value[1]]
        neighbour_info[key] = {
          location: location,
          empty: @matrix[location[0], location[1]].nil?
        }
      end

      return nil if neighbour_info.all? { |key, value| value[:empty] }

      ruleset_index = starting_ruleset
      proposed_move = nil

      Day23::RULESETS.size.times do
        ruleset = Day23::RULESETS[ruleset_index]
        if ruleset[:check].all? { |direction| neighbour_info[direction][:empty] }
          proposed_move = neighbour_info[ruleset[:move]][:location]
          break
        end
        ruleset_index = (ruleset_index + 1) % Day23::RULESETS.size
      end

      proposed_move
    end

    def move(new_row, new_col)
      @matrix[row, col] = nil
      @matrix[new_row, new_col] = self
      @row = new_row
      @col = new_col
    end
  end
end
