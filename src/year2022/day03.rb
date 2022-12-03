module Year2022
  class Day03
    def part1(input)
      scores = {}

      ('a'..'z').each.with_index do |letter, index|
        scores[letter] = index + 1
      end
      ('A'..'Z').each do |letter|
        scores[letter] = scores[letter.downcase] + 26
      end

      rows = input.split("\n").map do |row|
        row[0..(row.length/2 - 1)].chars.to_set.intersection(row[(row.length/2)..(row.length-1)].chars.to_set).first
      end

      score = 0

      rows.each do |row|
        score += scores[row]
      end

      score
    end

    def part2(input)
      scores = {}

      ('a'..'z').each.with_index do |letter, index|
        scores[letter] = index + 1
      end
      ('A'..'Z').each do |letter|
        scores[letter] = scores[letter.downcase] + 26
      end

      rows = input.split("\n").each_slice(3).map do |row|
        row = row.map(&:chars)
        row[0].intersection(row[1], row[2]).first
      end

      score = 0

      rows.each do |row|
        score += scores[row]
      end

      score
    end
  end
end
