module Year2024
  class Day11
    def part1(input)
      stones = input.split

      for blink in 1..25
        new_stones = []

        stones.each do |stone|
          if stone == '0'
            new_stones << '1'
          elsif stone.size % 2 == 0
            new_stones << stone.slice(0, stone.size / 2).to_i.to_s
            new_stones << stone.slice(stone.size / 2, stone.size / 2).to_i.to_s
          else
            new_stones << (stone.to_i * 2024).to_s
          end
        end
        # byebug

        stones = new_stones
      end

      stones.size
    end

    def part2(input)
      stones = input.split

      memo_table = {}
      total = 0

      stones.each do |root|
        t = dfs(memo_table, root, 75)
        memo_table[root][75] = t
        total += t
      end

      total
    end

    private

    def dfs(memo_table, stone, depth)
      return 1 if depth == 0
      return memo_table[stone][depth] if memo_table[stone] && memo_table[stone][depth]

      result = []

      if stone == '0'
        result << '1'
      elsif stone.size % 2 == 0
        result << stone.slice(0, stone.size / 2).to_i.to_s
        result << stone.slice(stone.size / 2, stone.size / 2).to_i.to_s
      else
        result << (stone.to_i * 2024).to_s
      end

      length = 0
      result.each { |num| length += dfs(memo_table, num, depth - 1)}

      memo_table[stone] ||= {}
      memo_table[stone][depth] = length
      length
    end
  end
end
