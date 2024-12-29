require 'matrix'

module Year2024
  class Day13
    def part1(input)
      score = 0

      input.split("\n").each_slice(4) do |slice|
        coefficients = []
        coefficients << slice[0].scan(/Button A: X\+(\d+), Y\+(\d+)/).first.map(&:to_i)
        coefficients << slice[1].scan(/Button B: X\+(\d+), Y\+(\d+)/).first.map(&:to_i)

        matrix = Matrix[[coefficients[0][0], coefficients[1][0]], [coefficients[0][1], coefficients[1][1]]]
        constants = Vector[*slice[2].scan(/Prize: X=(\d+), Y=(\d+)/).first.map(&:to_i)]
        # matrix = Matrix[[94, 22], [34, 67]]
        # constants = Vector[8400, 5400]

        # Solve for x and y
        if matrix.square? && matrix.det != 0
          solution = matrix.inverse * constants
          a, b = solution[0], solution[1]
          score += a * 3 + b if a.to_i == a && b.to_i == b
          # byebug
        end
      end

      score.to_i
    end

    def part2(input)
      score = 0

      input.split("\n").each_slice(4) do |slice|
        coefficients = []
        coefficients << slice[0].scan(/Button A: X\+(\d+), Y\+(\d+)/).first.map(&:to_i)
        coefficients << slice[1].scan(/Button B: X\+(\d+), Y\+(\d+)/).first.map(&:to_i)

        matrix = Matrix[[coefficients[0][0], coefficients[1][0]], [coefficients[0][1], coefficients[1][1]]]
        constants = Vector[*slice[2].scan(/Prize: X=(\d+), Y=(\d+)/).first.map(&:to_i)]
        constants = constants.map { |prize| prize + 10000000000000 }
        # matrix = Matrix[[94, 22], [34, 67]]
        # constants = Vector[8400, 5400]

        # Solve for x and y
        if matrix.square? && matrix.det != 0
          solution = matrix.inverse * constants
          a, b = solution[0], solution[1]
          score += a * 3 + b if a.to_i == a && b.to_i == b
          # byebug
        end
      end

      score.to_i
    end
  end
end
