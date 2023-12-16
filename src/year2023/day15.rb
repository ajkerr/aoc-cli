module Year2023
  class Day15
    def part1(input)
      lines = input.strip.split(',')

      sum = 0

      lines.each do |line|
        sum += hash(line)
      end

      sum
    end

    def part2(input)
      lines = input.strip.split(',')

      boxes = {}

      lines.each do |line|
        parsed_line = line.scan(/([a-z]+)([\-|=])(.*)/).first
        label = parsed_line.first
        box_number = hash(label)

        if parsed_line[1] == '='
          boxes[box_number] = [] if boxes[box_number].nil?
          lenses = boxes[box_number]
          lens = lenses.find { |lens| lens.label == label }
          if lens.nil?
            boxes[box_number] << Lens.new(label:, focal_length: parsed_line[2].to_i)
          else
            lens.focal_length = parsed_line[2].to_i
          end
        else
          unless boxes[box_number].nil?
            lenses = boxes[box_number]
            lens = lenses.find { |lens| lens.label == label }
            lenses.delete(lens) unless lens.nil?
          end
        end
      end

      power = 0

      boxes.each do |key, value|
        value.each.with_index do |lens, index|
          power += (key + 1) * (index + 1) * lens.focal_length
        end
      end

      power
    end

    private

    def hash(text)
      result = 0

      text.split('').each do |char|
        result = ((result + char.ord) * 17) % 256
      end

      result
    end
  end

  class Lens
    attr_reader :label
    attr_accessor :focal_length

    def initialize(label:, focal_length:)
      @label = label
      @focal_length = focal_length
    end
  end
end
