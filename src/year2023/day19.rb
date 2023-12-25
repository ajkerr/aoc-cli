module Year2023
  class Day19
    def part1(input)
      workflows = []
      parts = []

      found_all_workflows = false

      input.split("\n").each do |line|
        if line.strip == ''
          found_all_workflows = true
          next
        end

        if found_all_workflows
          parts << line
        else
          workflows << line
        end
      end

      workflows = workflows.inject({}) do |hash, line|
        parsed_line = line.scan(/([a-z]+){(.*)}/).first
        hash[parsed_line[0]] = Workflow.new(parsed_line[1])
        hash
      end

      parts = parts.map do |line|
        parsed_line = line.scan(/{x=(\d+),m=(\d+),a=(\d+),s=(\d+)}/).first.map(&:to_i)
        { x: parsed_line[0], m: parsed_line[1], a: parsed_line[2], s: parsed_line[3] }
      end

      parts.each do |part|
        next_workflow = 'in'

        while true
          result = workflows[next_workflow].apply(part)
          # byebug
          if result == 'A'
            part[:approved] = true
            break
          elsif result == 'R'
            part[:approved] = false
            break
          else
            next_workflow = result
          end
        end
      end

      sum = 0
      sum = parts.select { |part| part[:approved] }.inject(0) do |sum, part|
        sum += part[:x] + part[:m] + part[:a] + part[:s]
      end

      sum
    end

    def part2(input)
      workflows = []

      input.split("\n").each do |line|
        break if line.strip == ''
        workflows << line
      end

      workflows = workflows.inject({}) do |hash, line|
        parsed_line = line.scan(/([a-z]+){(.*)}/).first
        hash[parsed_line[0]] = Workflow.new(parsed_line[1])
        hash
      end

      parts = []
      parts << { x: (1..4000), m: (1..4000), a: (1..4000), s: (1..4000), workflow: 'in' }
      approved = []

      until parts.empty?
        part = parts.pop
        next_workflow = part[:workflow]

        if next_workflow == 'A'
          approved << part.except(:workflow)
          next
        elsif next_workflow == 'R'
          next
        end

        workflows[next_workflow].rules.each do |rule|
          category = rule.category

          case category
          when :x, :m, :a, :s
            other = part.dup
            other[:workflow] = rule.action
            range = part[category]

            case rule.operator
            when '<'
              other[category] = (range.begin..rule.value-1)
              part[category] = (rule.value..range.end)
            when '>'
              other[category] = (rule.value+1..range.end)
              part[category] = (range.begin..rule.value)
            end

            parts << other
          else
            part[:workflow] = rule.action
            parts << part
            break
          end
        end

      end

      approved.map { |part| part.values.reduce(1) { |acc, range| acc *= range.size } }.sum
    end
  end

  class Workflow
    attr_reader :rules

    def initialize(line)
      @rules = line.split(',').map { |rule| Rule.new(rule) }
    end

    def apply(part)
      result = nil
      @rules.each do |rule|
        result = rule.apply(part)
        break unless result.nil?
      end
      result
    end
  end

  class Rule
    attr_reader :category, :operator, :value, :action

    def initialize(rule)
      parsed_rule = rule.scan(/([a-z]+)([<|>])(\d+):([a-z|A|R]+)/)
      if parsed_rule.empty?
        @action = rule
      else
        parsed_rule = parsed_rule.first
        @category = parsed_rule[0].to_sym
        @operator = parsed_rule[1]
        @value = parsed_rule[2].to_i
        @action = parsed_rule[3]
      end
    end

    def apply(part)
      if @category.nil?
        return @action
      elsif part[@category].public_send(@operator, @value)
        return @action
      end

      nil
    end
  end
end
