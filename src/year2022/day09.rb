module Year2022
  class Day09
    MOVES = {
      R: [1, 0],
      L: [-1, 0],
      U: [0, 1],
      D: [0, -1]
    }.freeze

    def part1(input)
      moves = input.split("\n")

      head_pos = [0, 0]
      tail_pos = [0, 0]

      visited_by_tail = Set.new
      visited_by_tail << tail_pos

      moves.each do |move|
        direction, count = move.split(" ")
        direction = direction.to_sym
        count = count.to_i

        count.times do |i|
          head_pos = move_head(head_pos, direction)
          tail_pos = move_tail(head_pos, tail_pos)
          visited_by_tail << tail_pos
        end
      end

      visited_by_tail.size
    end

    def part2(input)
      moves = input.split("\n")

      rope_positions = Array.new(10, [0, 0])

      visited_by_tail = Set.new
      visited_by_tail << rope_positions.last

      moves.each do |move|
        direction, count = move.split(" ")
        direction = direction.to_sym
        count = count.to_i

        count.times do |i|
          rope_positions[0] = move_head(rope_positions[0], direction)

          for i in 1..9 do
            rope_positions[i] = move_tail(rope_positions[i-1], rope_positions[i])
          end

          visited_by_tail << rope_positions.last
        end

        # byebug
      end

      visited_by_tail.size
    end

    private

    def move_head(head_pos, direction)
      [head_pos, MOVES[direction]].transpose.map {|x| x.reduce(:+)}
    end

    def move_tail(head_pos, tail_pos)
      difference = [head_pos, tail_pos].transpose.map {|x| x.reduce(:-)}
      if difference[0].abs <= 1 && difference[1].abs <= 1
        tail_pos
      else
        if difference[0].positive?
          tail_pos = [tail_pos[0] + 1, tail_pos[1]]
        end

        if difference[0].negative?
          tail_pos = [tail_pos[0] - 1, tail_pos[1]]
        end

        if difference[1].positive?
          tail_pos = [tail_pos[0], tail_pos[1] + 1]
        end

        if difference[1].negative?
          tail_pos = [tail_pos[0], tail_pos[1] - 1]
        end

        tail_pos
      end
    end
  end
end
