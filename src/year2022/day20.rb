module Year2022
  class Day20
    def part1(input)
      original_numbers = input.split("\n").map(&:to_i)
      number_locations = {}
      numbers = original_numbers.dup

      original_numbers.each.with_index do |number, index|
        number_locations[index] = index
      end

      original_numbers.each.with_index do |number, index|
        new_index = (number_locations[index] + number) % (original_numbers.size - 1)

#        byebug
        deleted = numbers.delete_at(number_locations[index])

        number_locations.each do |key, value|
          if value > number_locations[index]
            number_locations[key] = value - 1
          end
        end
        # byebug
        numbers.insert(new_index, deleted)

        number_locations.each do |key, value|
          if value >= new_index
            number_locations[key] = value + 1
          end
        end
        number_locations[index] = new_index
        # byebug
      end

      a = numbers[(numbers.index(0) + 1000) % original_numbers.size]
      b = numbers[(numbers.index(0) + 2000) % original_numbers.size]
      c = numbers[(numbers.index(0) + 3000) % original_numbers.size]

      # byebug
      a + b + c
    end

    def part2(input)
      original_numbers = input.split("\n").map { |number| number.to_i * 811589153 }
      number_locations = {}
      numbers = original_numbers.dup

      original_numbers.each.with_index do |number, index|
        number_locations[index] = index
      end

      10.times do
        original_numbers.each.with_index do |number, index|
          new_index = (number_locations[index] + number) % (original_numbers.size - 1)

          # byebug
          deleted = numbers.delete_at(number_locations[index])

          number_locations.each do |key, value|
            if value > number_locations[index]
              number_locations[key] = value - 1
            end
          end
          # byebug
          numbers.insert(new_index, deleted)

          number_locations.each do |key, value|
            if value >= new_index
              number_locations[key] = value + 1
            end
          end
          number_locations[index] = new_index
          # byebug
        end
      end

      a = numbers[(numbers.index(0) + 1000) % original_numbers.size]
      b = numbers[(numbers.index(0) + 2000) % original_numbers.size]
      c = numbers[(numbers.index(0) + 3000) % original_numbers.size]

      # byebug
      a + b + c
    end
  end
end
