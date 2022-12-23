module Year2022
  class Day21
    def part1(input)
      monkeys = build_monkey_hash(input)
      monkeys['root'].evaluate(monkeys)
    end

    def part2(input)
      monkeys = build_monkey_hash(input)

      attempt = monkeys['root'].evaluate2(monkeys, 1i)
      (attempt[1].real - attempt[0].real) / (attempt[0].imaginary - attempt[1].imaginary)
    end

    private

    def build_monkey_hash(input)
      monkeys = {}

      lines = input.split("\n").each do |line|
        monkey = Monkey21.new(line)
        monkeys[monkey.name] = monkey
      end

      monkeys
    end
  end

  class Monkey21
    attr_reader :name

    def initialize(line)
      matches = /([a-z]+): (\d+)/.match(line)
      if matches.nil?
        matches = /([a-z]+): ([a-z]+) (\+|\-|\*|\/) ([a-z]+)/.match(line)
        @name = matches[1]
        @monkey_1 = matches[2]
        @operator = matches[3]
        @monkey_2 = matches[4]
      else
        @name = matches[1]
        @number = matches[2].to_i
      end

      def evaluate(monkeys)
        return @number unless @number.nil?

        case @operator
        when '+'
          monkeys[@monkey_1].evaluate(monkeys) + monkeys[@monkey_2].evaluate(monkeys)
        when '-'
          monkeys[@monkey_1].evaluate(monkeys) - monkeys[@monkey_2].evaluate(monkeys)
        when '*'
          monkeys[@monkey_1].evaluate(monkeys) * monkeys[@monkey_2].evaluate(monkeys)
        when '/'
          monkeys[@monkey_1].evaluate(monkeys) / monkeys[@monkey_2].evaluate(monkeys)
        end
      end

      def evaluate2(monkeys, human_value)
        return human_value if @name == 'humn'
        if @name == 'root'
          return [Complex(monkeys[@monkey_1].evaluate2(monkeys, human_value)), Complex(monkeys[@monkey_2].evaluate2(monkeys, human_value))]
        end
        return @number unless @number.nil?

        case @operator
        when '+'
          monkeys[@monkey_1].evaluate2(monkeys, human_value) + monkeys[@monkey_2].evaluate2(monkeys, human_value)
        when '-'
          monkeys[@monkey_1].evaluate2(monkeys, human_value) - monkeys[@monkey_2].evaluate2(monkeys, human_value)
        when '*'
          monkeys[@monkey_1].evaluate2(monkeys, human_value) * monkeys[@monkey_2].evaluate2(monkeys, human_value)
        when '/'
          monkeys[@monkey_1].evaluate2(monkeys, human_value) / monkeys[@monkey_2].evaluate2(monkeys, human_value)
        end
      end
    end
  end
end
