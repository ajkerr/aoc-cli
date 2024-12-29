module Year2024
  class Day08
    def part1(input)
      lines = input.split("\n").map { |line| line.split('') }

      antennas = Hash.new { |h, key| h[key] = [] }
      lines.each_with_index do |line, y|
        line.each_with_index do |value, x|
          antennas[value] << [x, y] unless value == '.'
        end
      end

      results = lines.map(&:dup)

      antennas.each do |key, locations|
        antinodes = []
        locations.combination(2).each do |pair|
          antinodes += find_extended_coordinates(pair)
        end
        antinodes.each do |antinode|
          if antinode[0] >=0 && antinode[0] < results[0].size &&
            antinode[1] >=0 && antinode[1] < results.size
            results[antinode[1]][antinode[0]] = '#'
          end
        end
      end
      # print_matrix(results)

      sum = 0

      results.each do |line|
        line.each do |char|
          sum += 1 if char == '#'
        end
      end

      sum
    end

    def part2(input)
      lines = input.split("\n").map { |line| line.split('') }

      antennas = Hash.new { |h, key| h[key] = [] }
      lines.each_with_index do |line, y|
        line.each_with_index do |value, x|
          antennas[value] << [x, y] unless value == '.'
        end
      end

      results = lines.map(&:dup)

      antennas.each do |key, locations|
        antinodes = []
        locations.combination(2).each do |pair|
          antinodes += find_extended_coordinates_2(pair, results[0].size - 1, results.size - 1)
        end
        antinodes.each do |antinode|
          results[antinode[1]][antinode[0]] = '#'
        end
      end
      # print_matrix(results)

      sum = 0

      results.each do |line|
        line.each do |char|
          sum += 1 if char != '.'
        end
      end

      sum
    end

    private

    def print_matrix(rows)
      rows.each do |row|
        puts "#{row.join}\n"
      end
      puts "\n"
    end

    def find_extended_coordinates(coords)
      # Unpack the two coordinates in the array
      x1, y1 = coords[0]
      x2, y2 = coords[1]

      # Calculate the direction vector from p1 to p2
      dx = x2 - x1
      dy = y2 - y1

      # p3: twice as far from p1 as p2
      p3 = [x1 + 2 * dx, y1 + 2 * dy]

      # p4: twice as far from p2 as p1
      p4 = [x2 - 2 * dx, y2 - 2 * dy]

      # Return the array of the extended coordinates
      [p3, p4]
    end

    def find_extended_coordinates_2(coords, max_x, max_y)
      # Unpack the two coordinates in the array
      x1, y1 = coords[0]
      x2, y2 = coords[1]

      # Calculate the direction vector from p1 to p2
      dx = x2 - x1
      dy = y2 - y1

      antinodes = []

      for n in (2..Float::INFINITY)
        results = []

        # p3: n times as far from p1 as p2
        p3 = [x1 + n * dx, y1 + n * dy]
        results << p3 if p3[0] >= 0 && p3[0] <= max_x && p3[1] >= 0 && p3[1] <= max_y

        # p4: n times as far from p2 as p1
        p4 = [x2 - n * dx, y2 - n * dy]
        results << p4 if p4[0] >= 0 && p4[0] <= max_x && p4[1] >= 0 && p4[1] <= max_y

        break if results.empty?

        antinodes += results
      end

      # Return the array of the extended coordinates
      antinodes
    end
  end
end
