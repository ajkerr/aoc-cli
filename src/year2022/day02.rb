module Year2022
  class Day02
    MOVES = {
      A: :rock,
      B: :paper,
      C: :scissors,
      X: :rock,
      Y: :paper,
      Z: :scissors
    }.freeze

    SHAPE_SCORES = {
      rock: 1,
      paper: 2,
      scissors: 3
    }.freeze

    OUTCOME_SCORES = {
      win: 6,
      lose: 0,
      draw: 3
    }.freeze

    PART_2_DESIRED_OUTCOMES = {
      X: :lose,
      Y: :draw,
      Z: :win
    }.freeze

    def part1(input)
      games = input.split("\n").map { |game| game.split(" ").map(&:to_sym) }

      score = 0

      games.each do |game|
        outcome = outcome(MOVES[game[0]], MOVES[game[1]])
        score += OUTCOME_SCORES[outcome] + SHAPE_SCORES[MOVES[game[1]]]
      end

      score
    end

    def part2(input)
      games = input.split("\n").map { |game| game.split(" ").map(&:to_sym) }

      score = 0

      games.each do |game|
        required_move = required_move(MOVES[game[0]], PART_2_DESIRED_OUTCOMES[game[1]])
        score += OUTCOME_SCORES[PART_2_DESIRED_OUTCOMES[game[1]]] + SHAPE_SCORES[required_move]
      end

      score
    end

    private

    def outcome(player1, player2)
      case player2
      when :rock
        case player1
        when :rock
          :draw
        when :paper
          :lose
        when :scissors
          :win
        end
      when :paper
        case player1
        when :rock
          :win
        when :paper
          :draw
        when :scissors
          :lose
        end
      when :scissors
        case player1
        when :rock
          :lose
        when :paper
          :win
        when :scissors
          :draw
        end
      end
    end

    def required_move(player1, desired_result)
      case player1
      when :rock
        case desired_result
        when :win
          :paper
        when :lose
          :scissors
        when :draw
          :rock
        end
      when :paper
        case desired_result
        when :win
          :scissors
        when :lose
          :rock
        when :draw
          :paper
        end
      when :scissors
        case desired_result
        when :win
          :rock
        when :lose
          :paper
        when :draw
          :scissors
        end
      end
    end
  end
end
