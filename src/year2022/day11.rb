module Year2022
  class Day11
    def part1(input)
      monkey_hash = {}
      monkeys = input.split("\n\n").map { |settings| Monkey.new(settings.split("\n")) }
      monkeys.each { |monkey| monkey_hash[monkey.id] = monkey }

      for rounds in 1..20
        monkeys.each do |monkey|
          monkey.inspect_items(monkey_hash, 3)
        end
      end

      score = monkeys.map(&:inspection_count).max(2).inject(:*)
    end

    def part2(input)
      monkey_hash = {}
      monkeys = input.split("\n\n").map { |settings| Monkey.new(settings.split("\n")) }
      monkeys.each { |monkey| monkey_hash[monkey.id] = monkey }

      divisor = monkeys.map(&:test_divisor).inject(:*)

      for rounds in 1..10000
        monkeys.each do |monkey|
          monkey.inspect_items(monkey_hash, divisor)
        end
      end

      counts = monkeys.map(&:inspection_count)

      score = monkeys.map(&:inspection_count).max(2).inject(:*)
    end
  end

  class Monkey
    attr_reader :id, :inspection_count, :test_divisor

    def initialize(settings)
      settings = settings.map(&:strip)

      @id = /Monkey (\d+):/.match(settings[0])[1].to_i
      @items = /Starting items: (.*)/.match(settings[1])[1].split(", ").map(&:to_i)

      matches = /Operation: new = old (\+|\*) (.*)/.match(settings[2])
      @operation = matches[1]
      @operand = matches[2]
      @test_divisor = /Test: divisible by (\d+)/.match(settings[3])[1].to_i
      @throw_to_if_true = /If true: throw to monkey (\d)+/.match(settings[4])[1].to_i
      @throw_to_if_false = /If false: throw to monkey (\d)+/.match(settings[5])[1].to_i

      @inspection_count = 0
    end

    def add_item(item)
      @items << item
    end

    def inspect_items(monkey_hash, divisor)
      @items.each do |item|
        @inspection_count += 1
        new_item = 0
        case @operation
        when '+'
          new_item = item + (@operand == 'old' ? item : @operand.to_i)
        when '*'
          new_item = item * (@operand == 'old' ? item : @operand.to_i)
        end

        if divisor == 3
          new_item /= divisor
        else
          new_item %= divisor
        end

        if new_item % @test_divisor == 0
          monkey_hash[@throw_to_if_true].add_item(new_item)
        else
          monkey_hash[@throw_to_if_false].add_item(new_item)
        end
      end

      @items = []
    end
  end
end
