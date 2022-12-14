module Year2022
  class Day13
    RIGHT = -1
    WRONG = 1
    UNKNOWN = 0

    def part1(input)
      pairs = input.split("\n\n").map { |pair| pair.split("\n").map { |string| eval(string.gsub(/(\w+?)/, "'\\1'")) } }

      sum = 0

      pairs.each.with_index do |pair, index|
        result = right_order?(pair)
        # byebug
        sum += (index + 1) if result == RIGHT
      end

      sum
    end

    def part2(input)
      packets = input.split("\n").reject!(&:empty?)
      # byebug
      packets << "[[2]]"
      packets << "[[6]]"

      packets = packets.map { |string| eval(string.gsub(/(\w+?)/, "'\\1'")) }

      packets = packets.sort do |a, b|
        right_order?([a, b])
      end

      # byebug
      (packets.index([["2"]]) + 1) * (packets.index([["6"]]) + 1)
    end

    private

    def right_order?(pair)
      # byebug
      return RIGHT if pair.first.empty? && !pair.last.empty?
      return WRONG if !pair.first.empty? && pair.last.empty?
      return UNKNOWN if pair.first.empty? && pair.last.empty?

      item_1 = pair.first.first
      item_2 = pair.last.first

      if item_1.kind_of?(String) && item_2.kind_of?(String)
        # byebug
        item_1 = item_1.to_i
        item_2 = item_2.to_i

        return RIGHT if item_1 < item_2
        return WRONG if item_1 > item_2
        return right_order?([pair.first.drop(1), pair.last.drop(1)])
      elsif item_1.kind_of?(Array) && item_2.kind_of?(Array)
        # byebug

        result = right_order?([item_1, item_2])
        if result == UNKNOWN
          return right_order?([pair.first.drop(1), pair.last.drop(1)])
        else
          return result
        end
      elsif item_1.kind_of?(Array) && item_2.kind_of?(String)
        # byebug
        new_pair = [pair[0], [[item_2]] + pair[1].drop(1)]
        return right_order?(new_pair)
      elsif item_1.kind_of?(String) && item_2.kind_of?(Array)
        # byebug
        new_pair = [[[item_1]] + pair[0].drop(1), pair[1]]
        return right_order?(new_pair)
      end

      UNKNOWN
    end
  end
end
