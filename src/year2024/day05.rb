module Year2024
  class Day05
    def part1(input)
      lines = input.split("\n")

      rules = []
      updates = []

      found_all_rules = false
      lines.each do |line|
        if line.empty?
          found_all_rules = true
          next
        end

        if found_all_rules
          updates << line.split(',').map(&:to_i)
        else
          # Parse rule
          rules << line.split('|').map(&:to_i)
        end
      end

      correct_update_indices = []

      updates.each_with_index do |update, i|
        update_good = true

        update.each_with_index do |page, j|
          pages_before = update[0...j]
          pages_after = update[j+1..-1]

          if !(pages_after.all? { |after| after?(page, after, rules) } &&
            pages_before.all? { |before| before?(page, before, rules) })
            update_good = false
            break
          end
        end

        correct_update_indices << i if update_good
      end

      score = 0

      correct_update_indices.each do |i|
        score += updates[i][updates[i].size / 2]
      end

      score
    end

    def part2(input)
      lines = input.split("\n")

      rules = []
      updates = []

      found_all_rules = false
      lines.each do |line|
        if line.empty?
          found_all_rules = true
          next
        end

        if found_all_rules
          updates << line.split(',').map(&:to_i)
        else
          # Parse rule
          rules << line.split('|').map(&:to_i)
        end
      end

      incorrect_update_indices = []

      updates.each_with_index do |update, i|
        update_good = true

        update.each_with_index do |page, j|
          pages_before = update[0...j]
          pages_after = update[j+1..-1]

          if !(pages_after.all? { |after| after?(page, after, rules) } &&
            pages_before.all? { |before| before?(page, before, rules) })
            update_good = false
            break
          end
        end

        incorrect_update_indices << i unless update_good
      end

      score = 0

      incorrect_update_indices.each do |i|
        bad_update = updates[i]

        corrected = bad_update.sort do |x, y|
          result = nil
          rules.each do |rule|
            if rule[0] == x && rule[1] == y
              result = -1
            end
            if rule[0] == y && rule[1] == x
              result = 1
            end
          end
          result
        end
        # bad_update.permutation(bad_update.size) do |update|
        #   update_good = true

        #   update.each_with_index do |page, j|
        #     pages_before = update[0...j]
        #     pages_after = update[j+1..-1]

        #     if !(pages_after.all? { |after| after?(page, after, rules) } &&
        #       pages_before.all? { |before| before?(page, before, rules) })
        #       update_good = false
        #       break
        #     end
        #   end

        #   if update_good
        #     corrected = update
        #     break
        #   end
        # end

        score += corrected[corrected.size / 2]
      end

      score
    end

    private

    def after?(page, after, rules)
      rules.any? { |rule| rule[0] == page && rule[1] == after }
    end

    def before?(page, before, rules)
      rules.any? { |rule| rule[1] == page && rule[0] == before }
    end
  end
end
