module Year2023
  class Day04
    def part1(input)
      lines = input.split("\n")

      sum = 0

      lines.each do |line|
        parsed_line = line.scan(/Card +(\d+):(.*)/)
        card_number = parsed_line.first.first.to_i
        rest = parsed_line.first.last

        number_sections = rest.split(' | ')
        winning_numbers = number_sections[0].strip.split(/\s+/).map(&:to_i).to_set
        elf_numbers = number_sections[1].strip.split(/\s+/).map(&:to_i)

        matching_numbers = 0

        elf_numbers.each do |number|
          matching_numbers += 1 if winning_numbers.include?(number)
        end
        # puts card_number
        # puts winning_numbers
        # puts elf_numbers
        # puts matching_numbers

        sum += if matching_numbers == 0
          0
        else
          2 ** (matching_numbers - 1)
        end
      end

      sum
    end

    def part2(input)
      lines = input.split("\n")

      cards = {}

      lines.each do |line|
        parsed_line = line.scan(/Card +(\d+):(.*)/)
        card_number = parsed_line.first.first.to_i
        rest = parsed_line.first.last

        number_sections = rest.split(' | ')
        winning_numbers = number_sections[0].strip.split(/\s+/).map(&:to_i).to_set
        elf_numbers = number_sections[1].strip.split(/\s+/).map(&:to_i)

        matching_numbers = 0

        elf_numbers.each do |number|
          matching_numbers += 1 if winning_numbers.include?(number)
        end
        # puts card_number
        # puts winning_numbers
        # puts elf_numbers
        # puts matching_numbers

        score = if matching_numbers == 0
          0
        else
          2 ** (matching_numbers - 1)
        end

        cards[card_number] = Card.new(card_number:, matching_numbers:, score:)
      end

      for i in 1..cards.size do
        card = cards[i]
        for n in (i+1)..(i+card.matching_numbers) do
          cards[n].bump_count_by(card.count)
        end
      end

      cards.values.inject(0) {|sum, card| sum + card.count }
    end

    class Card
      attr_reader :card_number, :matching_numbers, :score, :count

      def initialize(card_number:, matching_numbers:, score:)
        @card_number = card_number
        @matching_numbers = matching_numbers
        @score = score
        @count = 1
      end

      def bump_count_by(extra_cards)
        @count += extra_cards
      end
    end
  end
end
