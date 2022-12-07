require 'tree'

module Year2022
  class Day07
    def part1(input)
      root_node = build_tree(input)

      total = 0

      root_node.each do |node|
        if !node.children.empty? && node.content <= 100000
          total += node.content
        end
      end

      total
    end

    def part2(input)
      root_node = build_tree(input)

      total_disk_space = 70000000
      unused_space_needed = 30000000

      current_unused_space = total_disk_space - root_node.content
      target_removal_size = unused_space_needed - current_unused_space

      candidates = []

      root_node.each do |node|
        if !node.children.empty? && node.content >= target_removal_size
          candidates << node.content
        end
      end

      candidates.min
    end

    private

    def build_tree(input)
      rows = input.split("\n").map { |row| row.split(" ") }

      root_node = Tree::TreeNode.new("/", nil)

      current_node = root_node

      rows.each do |row|
        case row[0]
        when '$'
          case row[1]
          when 'cd'
            case row[2]
            when '/'
              current_node = root_node
            when '..'
              current_node = current_node.parent
            else
              current_node = current_node[row[2]]
            end
          when 'ls'
            next
          end
        when 'dir'
          current_node << Tree::TreeNode.new(row[1], nil)
        else
          current_node << Tree::TreeNode.new(row[1], row[0].to_i)
        end
      end

      #root_node.print_tree
      sum_directories(root_node)

      root_node
    end

    def sum_directories(node)
      return node.content if node.children.empty?

      node.content = 0

      node.children.each do |child|
        node.content += sum_directories(child)
      end

      node.content
    end
  end
end
