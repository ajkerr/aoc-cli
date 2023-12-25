module Year2023
  class Day18
    def part1(input)
      x = 0
      y = 0

      visited_points = [[0, 0]]
      perimeter = 0

      input.split("\n").each do |line|
        parsed_line = line.split(" ")
        direction = parsed_line[0]
        length = parsed_line[1].to_i
        colour = parsed_line[2]

        case direction
        when 'R'
          x += length
        when 'D'
          y += length
        when 'L'
          x -= length
        when 'U'
          y -= length
        end

        perimeter += length
        visited_points << [x,y]
      end

      # Shoelace algorithm
      area = visited_points.each_cons(2).sum do |p1, p2|
        p1_x, p1_y = p1
        p2_x, p2_y = p2
        p1_x * p2_y - p1_y * p2_x
      end.abs / 2

      # Pick's theorem
      area + (perimeter / 2) + 1
    end

    def part2(input)
      x = 0
      y = 0

      visited_points = [[0, 0]]
      perimeter = 0

      input.split("\n").each do |line|
        parsed_line = line.split(" ")

        length = parsed_line[2][2..6].to_i(16)
        direction = case parsed_line[2][7]
        when '0'
          'R'
        when '1'
          'D'
        when '2'
          'L'
        when '3'
          'U'
        end

        case direction
        when 'R'
          x += length
        when 'D'
          y += length
        when 'L'
          x -= length
        when 'U'
          y -= length
        end

        perimeter += length
        visited_points << [x, y]
      end

      # Shoelace algorithm
      area = visited_points.each_cons(2).sum do |p1, p2|
        p1_x, p1_y = p1
        p2_x, p2_y = p2
        p1_x * p2_y - p1_y * p2_x
      end.abs / 2

      # Pick's theorem
      area + (perimeter / 2) + 1
    end
  end
end
