module Year2024
  class Day10
    def part1(input)
      grid = input.split("\n").map { |line| line.chars.map(&:to_i) }

      trails = grid
        .each_with_index
        .flat_map do |row, y|
          # byebug
          row.each_index.flat_map do |x|
            # byebug
            find_trails(grid, 0, x, y)
          end
        end
      # byebug

      trails.group_by(&:first).sum { |_,trail| trail.map(&:last).uniq.size }
    end

    def part2(input)
      grid = input.split("\n").map { |line| line.chars.map(&:to_i) }

      trails = grid
        .each_with_index
        .flat_map do |row, y|
          # byebug
          row.each_index.flat_map do |x|
            # byebug
            find_trails(grid, 0, x, y)
          end
        end
      # byebug

      trails.size
    end

    private

    def in_bounds(grid, x, y) = y >= 0 && y < grid.length && x >= 0 && x < grid[y].length

    def find_trails(grid, v, x, y, steps=[[x,y]])
      return [] unless in_bounds(grid, x, y) && grid[y][x] == v
      return [steps] if v == 9

      return [[0,-1], [1,0], [0,1], [-1,0]]
        .map { |dx,dy| [x+dx, y+dy] }
        .flat_map { |nx, ny| find_trails(grid, v+1, nx, ny, [*steps, [nx,ny]]) }
    end
  end
end
