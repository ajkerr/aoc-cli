module Year2022
  class Day17
    CHAMBER_WIDTH = 7
    ROCK_TYPES = [:horizontal, :plus, :j, :verical, :box]

    def part1(input)
      calculate_height(input, 2022)
    end

    def part2(input)
      nil
    end

    private

    def calculate_height(input, rock_count)
      gusts = input.strip.chars
      current_gust = 0

      chamber = SparseMatrix.new
      current_top = 0

      cache = {}

      for i in 1..rock_count
        rock_type = ROCK_TYPES[(i-1) % ROCK_TYPES.size]
        cache_key = rock_type, current_gust

        if cache[cache_key].nil?

          rock = Rock.new(rock_type, current_top + 4, chamber)

          # puts "New rock"
          # print_chamber(current_top + 3 + rock.column_ranges.size, CHAMBER_WIDTH, chamber, rock.rock_matrix)
          # byebug
          rock_at_rest = false
          gust_turn = true

          while !rock_at_rest
            if gust_turn
              gust_result = case gusts[current_gust]
              when '<'
                rock.move_left
              when '>'
                rock.move_right
              end
              # puts "Gust #{gusts[current_gust]} success: #{gust_result}"
              current_gust = (current_gust + 1) % gusts.size
            else
              fall_result = rock.fall
              # puts "Fall success: #{fall_result}"
              unless fall_result
                rock.crystalize
                current_top = [rock.top + rock.column_ranges.size - 1, current_top].max
                rock_at_rest = true
              end
            end

            # print_chamber(current_top + 3 + rock.column_ranges.size, CHAMBER_WIDTH, chamber, rock.rock_matrix)
            # byebug
            gust_turn = !gust_turn
          end

          # cache[cache_key] = i, current_top
        else
          # cache_rock, cache_top = cache[cache_key]
          # # byebug
          # d, m = (rock_count - i).divmod(i - cache_rock)
          # if m.zero?
          #   current_top = (current_top + (current_top - cache_top) * d)
          # end
        end
      end

      current_top
    end

    def print_chamber(max_row, max_col, chamber, rock_matrix)
      print "\n"

      max_row.downto(1) do |row|
        1.upto(max_col) do |col|
          if !rock_matrix[row, col].nil?
            print rock_matrix[row, col]
          elsif chamber[row, col].nil?
            print '.'
          else
            print chamber[row, col]
          end
        end
        print "\n"
      end
    end
  end

  class Rock
    attr_reader :column_ranges, :rock_matrix, :top

    def initialize(type, top, chamber)
      @type = type
      @top = top
      @chamber = chamber

      case type
      when :horizontal
        @column_ranges = [3..6]
      when :plus
        @column_ranges = [4..4, 3..5, 4..4]
      when :j
        @column_ranges = [3..5, 5..5, 5..5]
      when :verical
        @column_ranges = [3..3, 3..3, 3..3, 3..3]
      when :box
        @column_ranges = [3..4, 3..4]
      end

      render_rock_matrix
    end

    def move_left
      @column_ranges.each.with_index do |range, i|
        return false if range.begin - 1 < 1 || !@chamber[@top + i, range.begin - 1].nil?
      end

      @column_ranges = @column_ranges.map do |range|
        (range.begin - 1)..(range.end - 1)
      end

      render_rock_matrix
      true
    end

    def move_right
      @column_ranges.each.with_index do |range, i|
        return false if range.end + 1 > Day17::CHAMBER_WIDTH || !@chamber[@top + i, range.end + 1].nil?
      end

      @column_ranges = @column_ranges.map do |range|
        (range.begin + 1)..(range.end + 1)
      end

      render_rock_matrix
      true
    end

    def fall
      return false if @top - 1 < 1

      @column_ranges.each.with_index do |range, i|
        range.each do |col|
          return false unless @chamber[@top + i - 1, col].nil?
        end
      end

      @top -= 1
      render_rock_matrix
      true
    end

    def crystalize
      @column_ranges.each.with_index do |range, i|
        range.each do |col|
          @chamber[@top + i, col] = "#"
        end
      end
    end

    private

    def render_rock_matrix
      @rock_matrix = SparseMatrix.new
      @column_ranges.each.with_index do |range, i|
        range.each do |col|
          @rock_matrix[@top + i, col] = "@"
        end
      end
    end
  end

  class SparseMatrix
    def initialize
      @hash = {}
    end

    def [](row, col)
      @hash[[row, col]]
    end

    def []=(row, col, val)
      @hash[[row, col]] = val
    end
  end
end
