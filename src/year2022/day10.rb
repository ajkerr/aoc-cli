module Year2022
  class Day10
    def part1(input)
      instructions = input.split("\n")

      cycle = 0
      x = 1
      signal_strengths = []

      instructions.each do |instruction|
        command, number = instruction.split(" ")
        number = number.to_i unless number.nil?

        signal_strengths << x * (cycle + 1)

        case command
        when 'noop'
          cycle += 1
        when 'addx'
          cycle += 1
          signal_strengths << x * (cycle + 1)
          cycle += 1
          x += number
        end

        break if cycle == 220
      end

      sum = 0
      signal_strengths.select.with_index do |signal, idx|
        sum += signal if [19, 59, 99, 139, 179, 219].include?(idx)
      end

      sum
    end

    def part2(input)
      instructions = input.split("\n")

      cycle = 0
      x = 1
      screen_rows = []
      pixels = ""

      instructions.each do |instruction|
        command, number = instruction.split(" ")
        number = number.to_i unless number.nil?

        sprite_positions = [x - 1, x, x + 1]

        case command
        when 'noop'
          sprite_positions.include?(cycle % 40) ? pixels += "#" : pixels += "."
          cycle += 1
        when 'addx'
          sprite_positions.include?(cycle % 40) ? pixels += "#" : pixels += "."
          cycle += 1
          sprite_positions.include?(cycle % 40) ? pixels += "#" : pixels += "."
          cycle += 1
          x += number
        end
      end

      pixels = pixels.chars.each_slice(40).to_a
      pixels.each { |row| puts row.join }

      nil
    end
  end
end
