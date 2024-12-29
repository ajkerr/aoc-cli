module Year2024
  class Day17
    def part1(input)
      lines = input.split("\n")

      @register_a = lines[0].scan(/Register A: (\d+)/).first.first.to_i
      @register_b = lines[1].scan(/Register B: (\d+)/).first.first.to_i
      @register_c = lines[2].scan(/Register C: (\d+)/).first.first.to_i

      instructions = lines[4].scan(/Program: (.*)/).first.first.split(',').map(&:to_i)

      outputs = []
      pointer = 0

      # byebug
      while pointer < instructions.size
        opcode = instructions[pointer]
        operand = instructions[pointer + 1]
        # byebug
        case opcode
        when 0
          @register_a = @register_a / 2 ** combo_operand(operand)
          pointer += 2
        when 1
          @register_b = @register_b ^ operand
          pointer += 2
        when 2
          @register_b = combo_operand(operand) % 8
          pointer += 2
        when 3
          if @register_a == 0
            pointer += 2
          else
            pointer = operand
          end
        when 4
          @register_b = @register_b ^ @register_c
          pointer += 2
        when 5
          outputs << combo_operand(operand) % 8
          pointer += 2
        when 6
          @register_b = @register_a / 2 ** combo_operand(operand)
          pointer += 2
        when 7
          @register_c = @register_a / 2 ** combo_operand(operand)
          pointer += 2
        end

        # byebug
      end

      # byebug
      outputs.join(',')
    end

    def part2(input)
      lines = input.split("\n")

      @register_a = lines[0].scan(/Register A: (\d+)/).first.first.to_i
      @register_b = lines[1].scan(/Register B: (\d+)/).first.first.to_i
      @register_c = lines[2].scan(/Register C: (\d+)/).first.first.to_i

      instructions = lines[4].scan(/Program: (.*)/).first.first.split(',').map(&:to_i)

      starting_value = 0

      while true
        # puts "Trying #{starting_value}"
        @register_a = starting_value
        outputs = []
        pointer = 0

        # byebug
        while pointer < instructions.size
          opcode = instructions[pointer]
          operand = instructions[pointer + 1]
          # byebug
          case opcode
          when 0
            @register_a = @register_a / 2 ** combo_operand(operand)
            pointer += 2
          when 1
            @register_b = @register_b ^ operand
            pointer += 2
          when 2
            @register_b = combo_operand(operand) % 8
            pointer += 2
          when 3
            if @register_a == 0
              pointer += 2
            else
              pointer = operand
            end
          when 4
            @register_b = @register_b ^ @register_c
            pointer += 2
          when 5
            outputs << combo_operand(operand) % 8
            pointer += 2
          when 6
            @register_b = @register_a / 2 ** combo_operand(operand)
            pointer += 2
          when 7
            @register_c = @register_a / 2 ** combo_operand(operand)
            pointer += 2
          end

          # byebug
        end

        break if outputs == instructions
        starting_value += 1
      end

      # byebug
      starting_value
    end

    private

    def combo_operand(operand)
      case operand
      when 0..3
        operand
      when 4
        @register_a
      when 5
        @register_b
      when 6
        @register_c
      else
        raise "Invalid operand #{operand}"
      end
    end
  end
end
