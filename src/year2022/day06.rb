module Year2022
  class Day06
    def part1(input)
      find_answer(input, 4)
    end

    def part2(input)
      find_answer(input, 14)
    end

    private

    def find_answer(input, distinct_chars)
      buffer = []
      answer = -1

      input.chars.each.with_index do |char, index|
        buffer.push(char)
        buffer = buffer.last(distinct_chars)

        if buffer.uniq.size == distinct_chars
          answer = index + 1
          break
        end
      end

      answer
    end
  end
end
