module Year2022
  class Day18
    OFFSETS = [
      [ 1,  0,  0],
      [-1,  0,  0],
      [ 0,  1,  0],
      [ 0, -1,  0],
      [ 0,  0,  1],
      [ 0,  0, -1],
    ].freeze

    def part1(input)
      cubes = input.split("\n").map { |line| line.split(",").map(&:to_i) }

      covered_sides = 0

      cubes.each do |cube|
        OFFSETS.each do |offset|
          adjacent_side = [cube, offset].transpose.map(&:sum)
          covered_sides += 1 if cubes.include?(adjacent_side)
        end
      end

      6 * cubes.size - covered_sides
    end

    def part2(input)
      cubes = input.split("\n").map { |line| line.split(",").map(&:to_i) }

      min_values, max_values = find_min_max(cubes)
      non_air_pockets = Set.new
      air_pockets = Set.new
      covered_sides = 0

      cubes.each do |cube|
        OFFSETS.each do |offset|
          adjacent_side = [cube, offset].transpose.map(&:sum)
          if cubes.include?(adjacent_side)
            covered_sides += 1
          elsif !air_pockets.include?(adjacent_side) && !non_air_pockets.include?(adjacent_side)
            distances = breadth_first(adjacent_side, cubes, min_values, max_values)
            # all of the positions in `distances` returned are connected to the adj_position
            # therefore, if ANY of the of the positions are at the edges, then the position
            # is NOT an airpacket
            # However, if NONE of the positions are at the edges, then it is an air pocket
            # print(distances)
            if is_air_pocket(distances, min_values, max_values)
                # puts("AIR POCKET FOUND")
                distances.keys.each { |distance| air_pockets.add(distance) }
            else
                # puts("NON AIR POCKET FOUND")
                distances.keys.each { |distance| non_air_pockets.add(distance) }
            end
          end
        end
      end

      cubes.each do |cube|
        x, y, z = cube

        OFFSETS.each do |offset|
          dx, dy, dz = offset
          adj_position = [x + dx, y + dy, z + dz]
          if air_pockets.include?(adj_position)
              covered_sides += 1
          end
        end
      end

      6 * cubes.size - covered_sides
    end

    private

    def find_min_max(cubes)
      xlist, ylist, zlist = [], [], []
      cubes.each do |cube|
        x, y, z = cube
        xlist.append(x)
        ylist.append(y)
        zlist.append(z)
      end

      min_values = [xlist.min, ylist.min, zlist.min]
      max_values = [xlist.max, ylist.max, zlist.max]

      [min_values, max_values]
    end

    def breadth_first(start, cubes, min_values, max_values)
      queue = [start]
      distances = {}
      distances[start] = 0
      minx, miny, minz = min_values
      maxx, maxy, maxz = max_values

      while !queue.empty? do
        air_position = queue.pop
        x, y, z = air_position

        OFFSETS.each do |offset|
          dx, dy, dz = offset
          adj_position = [x + dx, y + dy, z + dz]
          if adj_position[0] < minx or adj_position[0] > maxx
            # out of bounds x axis
            next
          end
          if adj_position[1] < miny or adj_position[1] > maxy
            # out of bounds x axis
            next
          end
          if adj_position[2] < minz or adj_position[2] > maxz
            # out of bounds z axis
            next
          end
          if cubes.include?(adj_position)
            # blocked by a cube
            next
          end
          if distances.include?(adj_position)
            # already visited
            next
          end

          distances[adj_position] = distances[air_position] + 1
          queue.append(adj_position)
        end
      end

      distances
    end

    def is_air_pocket(distances, min_values, max_values)
      minx, miny, minz = min_values
      maxx, maxy, maxz = max_values
      distances.keys.each do |distance|
        x, y, z = distance
        return false if x <= minx or x >= maxx
        return false if y <= miny or y >= maxy
        return false if z <= minz or z >= maxz
      end
      true
    end
  end
end