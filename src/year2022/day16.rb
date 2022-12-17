require 'weighted_graph'
require 'adjacency_matrix'
require 'floyd_warshall'

module Year2022
  class Day16
    def initialize
      @score = 0
      @total_time = 30
    end

    def part1(input)
      setup(input)
      dfs(0, "AA", Set.new, 0)
      @score
    end

    def part2(input)
      @score = 0
      @total_time = 26

      setup(input)

      part2_score = 0

      # valves_to_visit = @valves.keys - ['AA']

      # valves_to_visit.combination((valves_to_visit.size / 2.0).ceil).each do |subset|
      #   other_subset = valves_to_visit - subset
      #   # byebug
      #   candidate_score = 0
      #   dfs(0, "AA", Set.new(subset), 0)
      #   candidate_score = @score
      #   dfs(0, "AA", Set.new(other_subset), 0)
      #   candidate_score += @score

      #   part2_score = [part2_score, candidate_score].max
      # end

      dfs(0, "AA", Set.new, 0, true)
      @score
    end

    private

    def setup(input)
      lines = input.split("\n")
      @valves = {}
      nodes = []

      lines.each do |line|
        matches = /Valve ([A-Z]+) has flow rate=(\d+); (tunnels lead|tunnel leads) to valve(s?) (.*)/.match(line)
        @valves[matches[1]] = Valve.new(name: matches[1], flow_rate: matches[2].to_i)
        nodes << matches[1]
      end

      active_valves = @valves.values.filter { |valve| valve.flow_rate > 0 }

      @graph = WeightedGraph::PositiveWeightedGraph.new

      lines.each do |line|
        matches = /Valve ([A-Z]+) has flow rate=(\d+); (tunnels lead|tunnel leads) to valve(s?) (.*)/.match(line)
        tunnels = matches[5].split(", ").each do |tunnel|
          @graph.add_undirected_edge(matches[1], tunnel, 1)
        end
      end

      matrix = AdjacencyMatrix::Matrix.new(nodes, @graph)

      optimizer = FloydWarshall::Optimizer.new(matrix)
      @distance_matrix = optimizer.run
    end

    def dfs(current_score, current_valve, visited, time, part2 = false)
      @score = [@score, current_score].max
      visited = visited.union(Set[current_valve])

      other_vertices = @valves.keys.reject { |key| key == current_valve || @valves[key].flow_rate == 0 }
      # byebug
      # adjacent_vertices = @graph.get_adjacent_vertices(current_valve)

      other_vertices.each do |valve|
        dist = @distance_matrix.get(current_valve, valve)
        # byebug
        next if dist == 0

        if !visited.include?(valve) && time + dist + 1 < @total_time
          dfs(
            current_score + (@total_time - time - dist - 1) * @valves[valve].flow_rate,
            valve,
            visited,
            time + dist + 1,
            part2
          )
        end
      end

      if part2
        dfs(current_score, "AA", visited, 0, false)
      end
    end
  end

  class Valve
    attr_reader :name, :flow_rate
    attr_accessor :open

    def initialize(name:, flow_rate:)
      @name = name
      @flow_rate = flow_rate
      @open = false
    end
  end
end
