module Year2023
  class Day02
    def part1(input)
      lines = input.split("\n")

      sum = 0

      games = lines.map do |line|
        parsed_line = line.scan(/Game (\d+): (.*)/).first
        game_id = parsed_line.first.to_i
        grabs = parsed_line.last.split('; ').map do |grab_text|
          grab = Grab.new

          grab_text.split(', ').each do |cube_grab|
            parsed_cube_grab = cube_grab.scan(/(\d+) (red|green|blue)/).first

            if parsed_cube_grab.last == 'red'
              grab.red = parsed_cube_grab.first.to_i
            elsif parsed_cube_grab.last == 'green'
              grab.green = parsed_cube_grab.first.to_i
            else
              grab.blue = parsed_cube_grab.first.to_i
            end
          end

          grab
        end

        game = Game.new(id: game_id, grabs: grabs)
        if game.possible?(red: 12, green: 13, blue: 14)
          sum += game.id
        end
      end

      sum
    end

    def part2(input)
      lines = input.split("\n")

      sum = 0

      games = lines.map do |line|
        parsed_line = line.scan(/Game (\d+): (.*)/).first
        game_id = parsed_line.first.to_i
        grabs = parsed_line.last.split('; ').map do |grab_text|
          grab = Grab.new

          grab_text.split(', ').each do |cube_grab|
            parsed_cube_grab = cube_grab.scan(/(\d+) (red|green|blue)/).first

            if parsed_cube_grab.last == 'red'
              grab.red = parsed_cube_grab.first.to_i
            elsif parsed_cube_grab.last == 'green'
              grab.green = parsed_cube_grab.first.to_i
            else
              grab.blue = parsed_cube_grab.first.to_i
            end
          end

          grab
        end

        game = Game.new(id: game_id, grabs: grabs)
        sum += game.power
      end

      sum
    end

    class Game
      attr_reader :id

      def initialize(id:, grabs:)
        @id = id
        @grabs = grabs
      end

      def possible?(red:, green:, blue:)
        @grabs.all? do |grab|
          grab.red <= red && grab.green <= green && grab.blue <= blue
        end
      end

      def power
        max_red = @grabs.map(&:red).max
        max_green = @grabs.map(&:green).max
        max_blue = @grabs.map(&:blue).max
        max_red * max_green * max_blue
      end
    end

    class Grab
      attr_accessor :red, :green, :blue

      def initialize
        @red = 0
        @green = 0
        @blue = 0
      end
    end
  end
end
