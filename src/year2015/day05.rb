module Year2015
  class Day05

    VOWELS = ['a', 'e', 'i', 'o', 'u']
    DOUBLE_LETTERS = ('a'..'z').to_a.map { |letter| letter+letter }
    BAD_STRINGS = ['ab', 'cd', 'pq', 'xy']

    def part1(input)
      strings = input.split("\n")

      nice_count = 0

      strings.each do |string|
        vowel_count = VOWELS.inject(0) { |sum, vowel| sum + string.count(vowel) }
        next unless vowel_count >= 3

        next unless DOUBLE_LETTERS.any? { |dl| string.include?(dl) }

        next if BAD_STRINGS.any? { |dl| string.include?(dl) }

        nice_count += 1
      end

      nice_count
    end

    def part2(input)
      strings = input.split("\n")

      nice_count = 0

      strings.each do |string|

        next unless string.match(/(..).*\1/) && string.match(/(.).\1/)
        # doubles = []

        # string.chars.each_cons(2) {|element| doubles.push(element) }
        # doubles = doubles.chunk(&:itself).map(&:first)

        # next unless doubles.tally.values.any? { |count| count > 1 }

        # trebles = []

        # string.chars.each_cons(3) {|element| trebles.push(element) }
        # next unless trebles.any? { |treble| treble[0] == treble[2] }

        nice_count += 1
      end

      nice_count
    end
  end
end
