require 'set'

module Year2024
  class Day07
    def part1(input)
      lines = input.split("\n")

      equations = lines.map do |line|
        result = line.split(':')
        equation = []
        equation << result[0].to_i
        equation << result[1].split.map(&:to_i)
      end

      possible = 0

      equations.each do |equation|
        results = Set.new
        results.add(equation[1].first)

        equation[1][1..-1].each do |number|
          old_results = results
          results = Set.new

          old_results.each do |value|
            results.add(number + value)
            results.add(number * value)
          end
        end
        possible += equation[0] if results.include?(equation[0])
      end

      possible
    end

    def part2(input)
      lines = input.split("\n")

      equations = lines.map do |line|
        result = line.split(':')
        equation = []
        equation << result[0].to_i
        equation << result[1].split.map(&:to_i)
      end

      possible = 0

      equations.each do |equation|
        results = Set.new
        results.add(equation[1].first)

        equation[1][1..-1].each do |number|
          old_results = results
          results = Set.new

          old_results.each do |value|
            results.add(number + value)
            results.add(number * value)
            results.add("#{value}#{number}".to_i)
          end
        end
        possible += equation[0] if results.include?(equation[0])
      end

      possible
    end
  end
end
