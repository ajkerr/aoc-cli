module Year2024
  class Day14
    def part1(input)
      robots = input.split("\n").map do |line|
        results = line.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/).first.map(&:to_i)
        Robot.new(*results)
      end

      max_x = robots.max {|a, b| a.x <=> b.x }.x + 1
      max_y = robots.max {|a, b| a.y <=> b.y }.y + 1

      grid = Array.new(max_y) { Array.new(max_x) { [] } }

      # byebug
      robots.each do |robot|
        grid[robot.y][robot.x] << robot
        # byebug
      end

      print_matrix(grid)

      for second in 1..100
        robots.each do |robot|
          robot.move(grid, max_x, max_y)
        end
        # print_matrix(grid)
        # byebug
      end

      print_matrix(grid)

      quadrant_counts = []

      count = 0
      for y in 0..(max_y/2-1)
        for x in 0..(max_x/2-1)
          count += grid[y][x].size
        end
      end

      quadrant_counts << count

      count = 0
      for y in 0..(max_y/2-1)
        for x in (max_x/2+1)...max_x
          count += grid[y][x].size
        end
      end

      quadrant_counts << count

      count = 0
      for y in (max_y/2+1)...max_y
        for x in 0..(max_x/2-1)
          count += grid[y][x].size
        end
      end

      quadrant_counts << count

      count = 0
      for y in (max_y/2+1)...max_y
        for x in (max_x/2+1)...max_x
          count += grid[y][x].size
        end
      end

      quadrant_counts << count

      result = quadrant_counts.reduce(1, :*)
    end

    def part2(input)
      robots = input.split("\n").map do |line|
        results = line.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/).first.map(&:to_i)
        Robot.new(*results)
      end

      max_x = robots.max {|a, b| a.x <=> b.x }.x + 1
      max_y = robots.max {|a, b| a.y <=> b.y }.y + 1

      grid = Array.new(max_y) { Array.new(max_x) { [] } }

      # byebug
      robots.each do |robot|
        grid[robot.y][robot.x] << robot
        # byebug
      end

      print_matrix(grid)

      for second in 1..100_000
        robots.each do |robot|
          robot.move(grid, max_x, max_y)
        end

        grid.each do |row|
          if row.each_cons(8).any? { |group| group.all? { |cell| cell.is_a?(Array) && !cell.empty? } }
            print_matrix(grid)
            byebug
          end
        end
      # print_matrix(grid)
        # byebug
      end

      print_matrix(grid)

    end

    private

    def print_matrix(grid)
      grid.each do |row|
        row.each do |cell|
          if cell.size == 0
            print '.'
          else
            print cell.size
          end
        end
        print "\n"
      end
      print "\n"
    end
  end

  class Robot
    attr_accessor :x, :y, :v_x, :v_y

    def initialize(x, y, v_x, v_y)
      @x = x
      @y = y
      @v_x = v_x
      @v_y = v_y
    end

    def to_s
      "(#{x}, #{y}) (#{v_x}, #{v_y})"
    end

    def move(grid, max_x, max_y)
      grid[y][x].delete(self)
      @x = (@x + @v_x) % max_x
      @y = (@y + @v_y) % max_y
      grid[y][x] << self
    end
  end
end
