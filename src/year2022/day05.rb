module Year2022
  class Day05
    def part1(input)
      rows = input.split("\n")
      blank_row_index = rows.find_index("")
      moves = []

      stack_count = rows[blank_row_index-1].split(' ').map(&:to_i).max
      stack_item_indices = []
      for index in 0...stack_count
        if index == 0
          stack_item_indices << 1
        else
          stack_item_indices << stack_item_indices[index-1] + 4
        end
      end

      stacks = Array.new(stack_count) { [] }

      for index in (blank_row_index-2).downto(0)
        stacks.each.with_index do |stack, stack_index|
          item = rows[index][stack_item_indices[stack_index]]
          unless item.nil? || item.strip.empty?
            stack.push(item)
          end
        end
      end

      for index in (blank_row_index+1)...(rows.size)
        moves << rows[index].match(/move (\d+) from (\d+) to (\d+)/)[1..3].map(&:to_i)
      end

      moves.each do |move|
        move[0].times do
          item = stacks[move[1]-1].pop
          stacks[move[2]-1].push(item)
        end
      end

      answer = ""
      stacks.each do |stack|
        answer += stack.last
      end

      answer
    end

    def part2(input)
      rows = input.split("\n")
      blank_row_index = rows.find_index("")
      moves = []

      stack_count = rows[blank_row_index-1].split(' ').map(&:to_i).max
      stack_item_indices = []
      for index in 0...stack_count
        if index == 0
          stack_item_indices << 1
        else
          stack_item_indices << stack_item_indices[index-1] + 4
        end
      end

      stacks = Array.new(stack_count) { [] }

      for index in (blank_row_index-2).downto(0)
        stacks.each.with_index do |stack, stack_index|
          item = rows[index][stack_item_indices[stack_index]]
          unless item.nil? || item.strip.empty?
            stack.push(item)
          end
        end
      end

      for index in (blank_row_index+1)...(rows.size)
        moves << rows[index].match(/move (\d+) from (\d+) to (\d+)/)[1..3].map(&:to_i)
      end

      moves.each do |move|
        items_to_move = []
        move[0].times do
          items_to_move.prepend(stacks[move[1]-1].pop)
        end
        stacks[move[2]-1].push(*items_to_move)
      end

      answer = ""
      stacks.each do |stack|
        answer += stack.last
      end

      answer
    end
  end
end
