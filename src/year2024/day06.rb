require 'set'

module Year2024
  class Day06
    def part1(input)
      rows = input.split("\n").map do |line|
        line.split('')
      end

      robot = Robot.new(rows)

      # print_matrix(rows)

      while !robot.done
        robot.move
        # print_matrix(rows)
        # byebug
      end

      sum = 0

      rows.each do |row|
        row.each do |cell|
          sum += 1 if cell == 'X'
        end
      end

      sum
    end

    def part2(input)
      rows = input.split("\n").map do |line|
        line.split('')
      end

      sum = 0

      rows.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          next unless cell == '.'

          new_rows = rows.map(&:dup)
          new_rows[i][j] = '#'

          robot = Robot.new(new_rows)

          # print_matrix(rows)

          while !robot.done && !robot.cycle
            robot.move
            # print_matrix(rows)
            # byebug
          end

          # puts "Checked with new obstacle at #{j}, #{i}\n"
          sum += 1 if robot.cycle
          # puts "New count #{sum}"
        end
      end

      # byebug

      sum
    end

    private

    def print_matrix(rows)
      rows.each do |row|
        puts "#{row.join}\n"
      end
      puts "\n"
    end
  end

  class Robot
    attr_reader :done, :cycle
    attr_accessor :direction_index, :x, :y

    def initialize(rows)
      @rows = rows
      @min_x = 0
      @min_y = 0
      @max_x = rows[0].size - 1
      @max_y = rows.size - 1
      @direction_index = 0
      @done = false
      @cycle = false
      @seen = Set.new

      @rows.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == '^'
            @x = j
            @y = i
            @rows[i][j] = 'X'
            @seen.add("#{x},#{y},#{@direction_index}")
            break
          end
        end
      end
    end

    def move
      next_x = x
      next_y = y

      case direction_index
      when 0
        next_y = y - 1
      when 1
        next_x = x + 1
      when 2
        next_y = y + 1
      when 3
        next_x = x - 1
      end

      if out_of_bounds?(next_x, next_y)
        @done = true
        return
      end

      if @rows[next_y][next_x] != '#'
        @x = next_x
        @y = next_y
        @rows[y][x] = 'X'
      else
        turn_right
      end

      seen_key = "#{x},#{y},#{@direction_index}"
      if @seen.include?(seen_key)
        @cycle = true
      end
      @seen.add(seen_key)
    end

    def out_of_bounds?(next_x, next_y)
      next_x < @min_x || next_x > @max_x || next_y < @min_y || next_y > @max_y
    end

    def turn_right
      # byebug
      @direction_index = (direction_index + 1) % 4
    end
  end
end
