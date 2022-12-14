require 'rgl/adjacency'
require 'rgl/dijkstra'

module Year2022
  class Day12
    def part1(input)
      matrix = input.split("\n").map do |row|
        row.split('').map do |char|
          case char
          when 'S'
            96
          when 'E'
            123
          else
            char.ord
          end
        end
      end

      graph = RGL::DirectedAdjacencyGraph.new

      max_x_index = matrix.first.length-1
      max_y_index = matrix.length-1

      vertices = (0..max_x_index).to_a.product((0..max_y_index).to_a)
      graph.add_vertices(vertices)

      edge_weights = {}

      for y in 0..max_y_index
        for x in 0..max_x_index
          neighbour_coords(matrix, x, y, max_x_index, max_y_index).each do |neighbour|
            edge_weights[[[x, y], neighbour]] = 1
            graph.add_edge([x, y], neighbour)
          end
        end
      end

      start = find_node(matrix, 96, max_x_index, max_y_index)
      finish = find_node(matrix, 123, max_x_index, max_y_index)

      shortest_path = graph.dijkstra_shortest_path(edge_weights, start, finish)

      shortest_path.size - 1
    end

    def part2(input)
      matrix = input.split("\n").map do |row|
        row.split('').map do |char|
          case char
          when 'S'
            96
          when 'E'
            123
          else
            char.ord
          end
        end
      end

      graph = RGL::DirectedAdjacencyGraph.new

      max_x_index = matrix.first.length-1
      max_y_index = matrix.length-1

      vertices = (0..max_x_index).to_a.product((0..max_y_index).to_a)
      graph.add_vertices(vertices)

      edge_weights = {}

      for y in 0..max_y_index
        for x in 0..max_x_index
          neighbour_coords(matrix, x, y, max_x_index, max_y_index).each do |neighbour|
            edge_weights[[[x, y], neighbour]] = 1
            graph.add_edge([x, y], neighbour)
          end
        end
      end

      start = find_node(matrix, 96, max_x_index, max_y_index)
      finish = find_node(matrix, 123, max_x_index, max_y_index)

      shortest_path_lengths = []

      for y in 0..max_y_index
        for x in 0..max_x_index
          if matrix[y][x] == 'a'.ord || matrix[y][x] == 96
            shortest_path = graph.dijkstra_shortest_path(edge_weights, [x, y], finish)
            shortest_path_lengths << shortest_path.size - 1 unless shortest_path.nil?
          end
        end
      end

      shortest_path_lengths.min
    end

    private

    def neighbour_coords(matrix, x, y, max_x_index, max_y_index)
      neighbours = []
      # up
      neighbours << [x, y-1] if y > 0 && (matrix[y-1][x] - matrix[y][x]) <= 1

      # down
      neighbours << [x, y+1] if y < max_y_index && (matrix[y+1][x] - matrix[y][x]) <= 1

      # left
      neighbours << [x-1, y] if x > 0 && (matrix[y][x-1] - matrix[y][x]) <= 1

      # right
      neighbours << [x+1, y] if x < max_x_index && (matrix[y][x+1] - matrix[y][x]) <= 1

      neighbours
    end

    def find_node(matrix, value, max_x_index, max_y_index)
      for y in 0..max_y_index
        for x in 0..max_x_index
          return [x, y] if value == matrix[y][x]
        end
      end
    end
  end
end
