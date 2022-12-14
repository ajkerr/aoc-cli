module Year2022
  class Day08
    def part1(input)
      grid = input.split("\n").map { |row| row.chars.map(&:to_i) }

      grid_width = grid.first.size
      grid_height = grid.size

      # outer trees
      visible_count = grid_width * 2 + (grid_height - 2) * 2

      # inner trees
      for i in 1..(grid_width-2)
        for j in 1..(grid_height-2)
          visible_count += 1 if visible_tree?(i, j, grid, grid_width, grid_height)
          #puts "(#{i}, #{j}): #{grid[i][j]}"
        end
      end

      visible_count
    end

    def part2(input)
      grid = input.split("\n").map { |row| row.chars.map(&:to_i) }

      grid_width = grid.first.size
      grid_height = grid.size

      scenic_scores = []

      for i in 1..(grid_width-2)
        for j in 1..(grid_height-2)
          scenic_scores << scenic_score(i, j, grid, grid_width, grid_height)
        end
      end

      scenic_scores.max
    end

    private

    def visible_tree?(tree_i, tree_j, grid, grid_width, grid_height)
      height = grid[tree_i][tree_j]

      visible_from_top = true
      visible_from_left = true
      visible_from_right = true
      visible_from_bottom = true

      for i in 0...tree_i
        if grid[i][tree_j] >= height
          visible_from_top = false
          break
        end
      end

      for j in 0...tree_j
        if grid[tree_i][j] >= height
          visible_from_left = false
          break
        end
      end

      (grid_width - 1).downto(tree_j + 1) do |j|
        if grid[tree_i][j] >= height
          visible_from_right = false
          break
        end
      end

      (grid_height - 1).downto(tree_i + 1) do |i|
        if grid[i][tree_j] >= height
          visible_from_bottom = false
          break
        end
      end

      visible_from_top || visible_from_left || visible_from_right || visible_from_bottom
    end

    def scenic_score(tree_i, tree_j, grid, grid_width, grid_height)
      height = grid[tree_i][tree_j]

      up_score = 0
      down_score = 0
      left_score = 0
      right_score = 0

      (tree_i - 1).downto(0) do |i|
        # if grid[i][tree_j] <= height
          up_score += 1
        # end
        break if grid[i][tree_j] >= height
      end

      (tree_i + 1).upto(grid_height - 1) do |i|
        # if grid[i][tree_j] <= height
          down_score += 1
        # end
        break if grid[i][tree_j] >= height
      end

      (tree_j + 1).upto(grid_width - 1) do |j|
        # byebug
        # if grid[tree_i][j] <= height
          right_score += 1
        # end
        break if grid[tree_i][j] >= height
      end

      # byebug
      (tree_j - 1).downto(0) do |j|
        # if grid[tree_i][j] <= height
          left_score += 1
        # end
        break if grid[tree_i][j] >= height
      end
# byebug
      up_score * down_score * left_score * right_score
    end
  end
end
