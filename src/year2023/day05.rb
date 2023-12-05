module Year2023
  class Day05
    def part1(input)
      lines = input.split("\n")

      seeds = lines[0].split(/\s+/).map(&:to_i).drop(1)

      lines = lines.drop(1)

      maps = []

      while !lines.empty?
        if lines[0] == ''
          lines.shift
          name = lines.shift
          entries = []
          while !lines.empty? && lines[0].start_with?(/\d/)
            entries << lines.shift.split(' ').map(&:to_i)
          end

          maps << Map.new(name:, entries:)
        end
      end

      sources = seeds

      maps.each do |map|
        targets = []
        sources.each do |source|
          targets << map.get_destination(source:)
        end
        sources = targets
      end

      sources.min
    end

    def part2(input)
      lines = input.split("\n")

      seeds = lines[0].split(/\s+/).map(&:to_i).drop(1)

      seed_ranges = []

      seeds.each_slice(2) do |pair|
        seed_ranges << (pair[0]...(pair[0] + pair[1]))
        # byebug
      end

      lines = lines.drop(1)

      maps = []

      while !lines.empty?
        if lines[0] == ''
          lines.shift
          name = lines.shift
          entries = []
          while !lines.empty? && lines[0].start_with?(/\d/)
            entries << lines.shift.split(' ').map(&:to_i)
          end

          maps << Map.new(name:, entries:)
        end
      end

      maps = maps.reverse
      lowest_location = -1

      (0..).each do |location|
        source = nil
        destination = location

        maps.each do |map|
          source = map.get_source(destination: destination)
          destination = source
        end

        # if location == 46
        #   puts "Got seed of #{source} for 46"
        # end

        if seed_ranges.any? { |seed_range| seed_range.cover?(source) }
          lowest_location = location
          break
        end
      end

      lowest_location
    end

    class Map
      attr_reader :name, :entries

      def initialize(name:, entries:)
        @name = name
        @entries = entries
      end

      def get_destination(source:)
        entries.each do |entry|
          # byebug
          if (entry[1]...(entry[1] + entry[2])).cover?(source)
            return entry[0] + source - entry[1]
          end
        end

        source
      end

      def get_source(destination:)
        entries.each do |entry|
          # byebug
          if (entry[0]...(entry[0] + entry[2])).cover?(destination)
            return entry[1] + destination - entry[0]
          end
        end

        destination
      end
    end
  end
end
