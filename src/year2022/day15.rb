module Year2022
  class Day15
    def part1(input)
      lines = input.split("\n")

      y_line = $0.end_with?('rspec') ? 10 : 2000000

      sensor_beacon_pairs = []
      matrix = SparseMatrix.new

      min_x = nil
      max_x = nil
      min_y = nil
      max_y = nil

      lines.each do |line|
        matches = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/.match(line)
        pair = {
          sensor: { x: matches[1].to_i, y: matches[2].to_i },
          beacon: { x: matches[3].to_i, y: matches[4].to_i },
        }
        pair[:distance] = distance(pair[:sensor], pair[:beacon])
        sensor_beacon_pairs << pair

        matrix[pair[:sensor][:x], pair[:sensor][:y]] = 'S'
        matrix[pair[:beacon][:x], pair[:beacon][:y]] = 'B'
        min_x = pair[:sensor][:x] if min_x.nil? || pair[:sensor][:x] < min_x
        min_x = pair[:beacon][:x] if min_x.nil? || pair[:beacon][:x] < min_x
        min_y = pair[:sensor][:y] if min_y.nil? || pair[:sensor][:y] < min_y
        min_y = pair[:beacon][:y] if min_y.nil? || pair[:beacon][:y] < min_y
        max_x = pair[:sensor][:x] if max_x.nil? || pair[:sensor][:x] > max_x
        max_x = pair[:beacon][:x] if max_x.nil? || pair[:beacon][:x] > max_x
        max_y = pair[:sensor][:y] if max_y.nil? || pair[:sensor][:y] > max_y
        max_y = pair[:beacon][:y] if max_y.nil? || pair[:beacon][:y] > max_y
      end

      # byebug
      # puts
      # print_matrix(matrix, min_x, min_y, max_x, max_y)

      covered_count = 0

      range_set = calculate_range_set(sensor_beacon_pairs, y_line)
      range_set.each do |range|
        for x in range
          if matrix[x, y_line].nil?
            covered_count += 1
          end
        end
      end

      covered_count
    end

    def part2(input)
      lines = input.split("\n")

      max_value = $0.end_with?('rspec') ? 20 : 4000000

      sensor_beacon_pairs = []
      matrix = SparseMatrix.new

      lines.each do |line|
        matches = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/.match(line)
        pair = {
          sensor: { x: matches[1].to_i, y: matches[2].to_i },
          beacon: { x: matches[3].to_i, y: matches[4].to_i },
        }
        pair[:distance] = distance(pair[:sensor], pair[:beacon])
        sensor_beacon_pairs << pair

        matrix[pair[:sensor][:x], pair[:sensor][:y]] = 'S'
        matrix[pair[:beacon][:x], pair[:beacon][:y]] = 'B'
      end

      for y in 0..max_value
        range_set = calculate_range_set(sensor_beacon_pairs, y, 0, max_value)
        if range_set.size == 2
          frequency = 4000000 * (range_set.first.end + 1) + y
          break
        end
      end

      frequency
    end

    private

    def print_matrix(matrix, min_x, min_y, max_x, max_y)
      for y in min_y..max_y
        for x in min_x..max_x
          if matrix[x, y].nil?
            print '.'
          else
            print matrix[x, y]
          end
        end
        print "\n"
      end
    end

    def distance(coord_1, coord_2)
      (coord_1[:x] - coord_2[:x]).abs + (coord_1[:y] - coord_2[:y]).abs
    end

    def calculate_range_set(sensor_beacon_pairs, y, min_x = nil, max_x = nil)
      ranges = []

      sensor_beacon_pairs.each do |pair|
        vertical_d = (pair[:sensor][:y] - y).abs
        next if vertical_d > pair[:distance]

        horizontal_d = pair[:distance] - vertical_d

        if min_x.nil? && max_x.nil?
          range = (pair[:sensor][:x] - horizontal_d)..(pair[:sensor][:x] + horizontal_d)
        else
          range = ([(pair[:sensor][:x] - horizontal_d), min_x].max)..([(pair[:sensor][:x] + horizontal_d), max_x].min)
        end

        ranges << range
      end

      merge_overlapping_ranges(ranges)
    end

    def merge_overlapping_ranges(overlapping_ranges)
      overlapping_ranges.sort_by(&:begin).inject([]) do |ranges, range|
        if !ranges.empty? && ranges_overlap?(ranges.last, range)
          ranges[0...-1] + [merge_ranges(ranges.last, range)]
        else
          ranges + [range]
        end
      end
    end

    def merge_ranges(a, b)
      [a.begin, b.begin].min..[a.end, b.end].max
    end

    def ranges_overlap?(a, b)
      a.include?(b.begin) || b.include?(a.begin)
    end
  end

  class SparseMatrix
    def initialize
      @hash = {}
    end

    def [](row, col)
      @hash[[row, col]]
    end

    def []=(row, col, val)
      @hash[[row, col]] = val
    end
  end
end
