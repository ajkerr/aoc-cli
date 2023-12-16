module Year2023
  class Day08
    def part1(input)
      lines = input.split("\n")

      instructions = lines.shift.split('')
      lines.shift

      rules = {}

      lines.each do |line|
        parsed_line = line.scan(/([A-Z]{3})/)
        id = parsed_line[0].first
        left = parsed_line[1].first
        right = parsed_line[2].first
        rules[id] = Rule.new(id:, left:, right:)
      end

      steps = 0
      current_location = 'AAA'
      instruction_index = 0

      while true do
        case instructions[instruction_index]
        when 'L'
          current_location = rules[current_location].left
        when 'R'
          current_location = rules[current_location].right
        end

        steps += 1

        break if current_location == 'ZZZ'

        instruction_index = (instruction_index + 1) % instructions.length
      end

      steps
    end

    def part2(input)
      lines = input.split("\n")

      instructions = lines.shift.split('')
      lines.shift

      rules = {}

      lines.each do |line|
        parsed_line = line.scan(/([A-Z|0-9]{3})/)
        id = parsed_line[0].first
        left = parsed_line[1].first
        right = parsed_line[2].first
        rules[id] = Rule.new(id:, left:, right:)
      end

      current_locations = rules.keys.select { |location| location.end_with?('A') }

      # puts "Starting locations: #{current_locations}"
      distances = {}

      current_locations.each.with_index do |location, index|
        current_location = location
        instruction_index = 0
        steps = 0

        while true do
          case instructions[instruction_index]
          when 'L'
            current_location = rules[current_location].left
          when 'R'
            current_location = rules[current_location].right
          end

          steps += 1

          if current_location.end_with?('Z')
            distances[location] = steps
            break
          end

          instruction_index = (instruction_index + 1) % instructions.length
        end
      end

      distances.values.reduce(&:lcm)
    end

    class Rule
      attr_reader :id, :left, :right

      def initialize(id:, left:, right:)
        @id = id
        @left = left
        @right = right
      end
    end
  end
end
