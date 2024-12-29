module Year2024
  class Day09
    def part1(input)
      id = 0
      disk = []

      input.split('').each_with_index do |item, i|
        if i % 2 == 0
          # block count of file
          item.to_i.times do
            disk << id
          end
          id += 1
        else
          # empty block count
          item.to_i.times do
            disk << '.'
          end
        end
      end

      puts "Generated disk, size is #{disk.size}"
      empty_indices = disk.each_with_index.select { |item, index| item == '.' }.map { |item, index| index }

      disk.reverse.each_with_index do |item, i|
        # puts i
        next if item == '.'
        index = disk.size - i - 1
        candidate = empty_indices.shift
        break if candidate > index
        disk[candidate] = item
        disk[index] = '.'
        # byebug
      end

      score = 0

      disk.each_with_index do |item, i|
        score += item.to_i * i
      end
      # byebug
      score
    end

    def part2(input)
      id = 0
      disk = []

      input.split('').each_with_index do |item, i|
        if i % 2 == 0
          # block count of file
          item.to_i.times do
            disk << id
          end
          id += 1
        else
          # empty block count
          item.to_i.times do
            disk << '.'
          end
        end
      end

      puts "Generated disk, size is #{disk.size}"

      empty_blocks = []
      start_index = nil

      disk.each_with_index do |item, index|
        if item == '.'
          # Mark the start of a block if it hasn't been marked already
          start_index ||= index
        elsif start_index
          # End the block when encountering a non-dot
          empty_blocks << [start_index, index - start_index]
          start_index = nil
        end
      end

      file_id = nil
      file_length = 0
      file_start = nil
      # byebug
      disk.reverse.each_with_index do |item, i|
        # puts "#{i}: #{item}"
        next if item == '.'

        if file_id.nil?
          file_id = item
          file_start = disk.size - i - 1
          file_length = 1
        elsif item == file_id
          file_length += 1
          file_start = disk.size - i - 1
        else
          block_index = empty_blocks.find_index { |block| block[1] >= file_length }

          unless block_index.nil?
            block = empty_blocks[block_index]

            for j in block[0]...(block[0]+file_length)
              disk[j] = file_id
            end
            # byebug
            for j in (file_start)...(file_start + file_length)
              disk[j] = '.'
            end
            if block[1] == file_length
              empty_blocks.delete_at(block_index)
            else
              block[0] += file_length
              block[1] -= file_length
            end
          end
          # byebug
          # new file
          file_id = item
          file_length = 1
          file_start = disk.size - i - 1
        end
      end

      # byebug
      score = 0

      disk.each_with_index do |item, i|
        score += item.to_i * i
      end
      # byebug
      score
    end
  end
end
