require 'digest'

module Year2015
  class Day04
    def part1(input)
      solve(input, '00000')
    end

    def part2(input)
      solve(input, '000000')
    end

    private 

    def solve(input, prefix)
      secret = input.strip
      result = 1

      loop do
        digest = Digest::MD5.hexdigest("#{secret}#{result}")

        # puts "#{secret}#{result}: #{digest}"
        break if digest.start_with?(prefix)

        result += 1
      end

      result
    end
  end
end
