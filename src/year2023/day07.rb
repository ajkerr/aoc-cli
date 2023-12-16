module Year2023
  class Day07
    CARD_TYPES = {
      'A' => 0,
      'K' => 1,
      'Q' => 2,
      'J' => 3,
      'T' => 4,
      '9' => 5,
      '8' => 6,
      '7' => 7,
      '6' => 8,
      '5' => 9,
      '4' => 10,
      '3' => 11,
      '2' => 12
    }.freeze

    CARD_TYPES_PART_2 = {
      'A' => 0,
      'K' => 1,
      'Q' => 2,
      'T' => 3,
      '9' => 4,
      '8' => 5,
      '7' => 6,
      '6' => 7,
      '5' => 8,
      '4' => 9,
      '3' => 10,
      '2' => 11,
      'J' => 12,
    }.freeze

    HAND_TYPES = {
      FIVE_OF_A_KIND: 0,
      FOUR_OF_A_KIND: 1,
      FULL_HOUSE: 2,
      THREE_OF_A_KIND: 3,
      TWO_PAIR: 4,
      ONE_PAIR: 5,
      HIGH_CARD: 6
    }.freeze

    def part1(input)
      lines = input.split("\n")

      hands = []

      lines.each do |line|
        line_parts = line.split(' ')
        cards = line_parts.first.split('')
        bid = line_parts.last.to_i
        hands << Hand.new(cards:, bid:)
      end

      hands = hands.sort do |hand1, hand2|
        if HAND_TYPES[hand1.hand_type] == HAND_TYPES[hand2.hand_type]
          result = nil
          hand1.cards.each.with_index do |card, index|
            next if CARD_TYPES[card] == CARD_TYPES[hand2.cards[index]]
            result = CARD_TYPES[hand2.cards[index]] - CARD_TYPES[card]
            break
          end
          # byebug
          result
        else
          HAND_TYPES[hand2.hand_type] - HAND_TYPES[hand1.hand_type]
        end
      end

      winnings = 0

      hands.each.with_index do |hand, index|
        winnings += (index + 1) * hand.bid
      end

      # byebug
      winnings
    end

    def part2(input)
      lines = input.split("\n")

      hands = []

      lines.each do |line|
        line_parts = line.split(' ')
        cards = line_parts.first.split('')
        bid = line_parts.last.to_i
        hands << HandPart2.new(cards:, bid:)
      end

      hands = hands.sort do |hand1, hand2|
        if HAND_TYPES[hand1.hand_type] == HAND_TYPES[hand2.hand_type]
          result = nil
          hand1.cards.each.with_index do |card, index|
            next if CARD_TYPES_PART_2[card] == CARD_TYPES_PART_2[hand2.cards[index]]
            result = CARD_TYPES_PART_2[hand2.cards[index]] - CARD_TYPES_PART_2[card]
            break
          end
          # byebug
          result
        else
          HAND_TYPES[hand2.hand_type] - HAND_TYPES[hand1.hand_type]
        end
      end

      winnings = 0

      hands.each.with_index do |hand, index|
        winnings += (index + 1) * hand.bid
      end

      # byebug
      winnings
    end

    class Hand
      attr_reader :cards, :bid, :card_counts, :hand_type

      def initialize(cards:, bid:)
        @cards = cards
        @bid = bid
        @card_counts = Hash.new(0)

        cards.each do |card|
          card_counts[card] += 1
        end

        counts = card_counts.values

        @hand_type = if counts.any? { |count| count == 5 }
          :FIVE_OF_A_KIND
        elsif counts.any? { |count| count == 4 }
          :FOUR_OF_A_KIND
        elsif counts.any? { |count| count == 3 }
          if counts.any? { |count| count == 2 }
            :FULL_HOUSE
          else
            :THREE_OF_A_KIND
          end
        elsif counts.count(2) == 2
          :TWO_PAIR
        elsif counts.count(2) == 1
          :ONE_PAIR
        else
          :HIGH_CARD
        end
      end
    end

    class HandPart2
      attr_reader :cards, :bid, :card_counts, :hand_type

      def initialize(cards:, bid:)
        @cards = cards
        @bid = bid
        @card_counts = Hash.new(0)

        cards.each do |card|
          card_counts[card] += 1
        end

        unless card_counts['J'].zero?
          jack_count = card_counts['J']
          highest_non_jack_count = 0
          highest_non_jack_card = nil

          card_counts.each do |card, count|
            next if card == 'J'
            if count > highest_non_jack_count
              highest_non_jack_count = count
              highest_non_jack_card = card
            elsif count == highest_non_jack_count
              if CARD_TYPES_PART_2[card] < CARD_TYPES_PART_2[highest_non_jack_card]
                highest_non_jack_count = count
                highest_non_jack_card = card
              end
            end
          end

          # puts "Cards: #{cards}"
          # puts "Jack count: #{jack_count}"
          # puts "Highest non-Jack card: #{highest_non_jack_card}"
          # puts "Highest non-Jack count: #{highest_non_jack_count}"

          card_counts[highest_non_jack_card] += jack_count
          card_counts['J'] = 0

          # puts "Updated counts: #{card_counts}"
        end

        counts = card_counts.values

        @hand_type = if counts.any? { |count| count == 5 }
          :FIVE_OF_A_KIND
        elsif counts.any? { |count| count == 4 }
          :FOUR_OF_A_KIND
        elsif counts.any? { |count| count == 3 }
          if counts.any? { |count| count == 2 }
            :FULL_HOUSE
          else
            :THREE_OF_A_KIND
          end
        elsif counts.count(2) == 2
          :TWO_PAIR
        elsif counts.count(2) == 1
          :ONE_PAIR
        else
          :HIGH_CARD
        end
      end
    end
  end
end
