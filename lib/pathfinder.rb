require 'pry'
class Pathfinder
  def initialize(landscape)
    @landscape = landscape
    @row_with_finish = correct_row("F")
    @row_with_start = correct_row("S")
  end

  def solve
    shortest_possible(winning_paths)
  end

  def shortest_possible(path)
    path.min do |p|
      p.count
    end
  end

  def winning_paths
    path_possibilities = []
    @landscape.size.times do |iteration|
      if iteration > 0
        all_coordinate_paths(iteration).select do |arrangement|
          if linked_from_start_to_finish(arrangement)
            path_possibilities << arrangement
          end
        end
      end
    end
      path_possibilities
  end

  def discount_walls
    @landscape.matrix.each do |row|
      row.delete_if do |spot|
        spot
      end
    end

  end

    def all_coordinate_paths(iteration_count)
      @landscape.matrix.keys.permutation(iteration_count)
    end

    def linked_from_start_to_finish(arrangement)
      arrangement.first == find_start && arrangement.last == find_finish && all_linked?(arrangement)
    end

    def all_linked?(path)
      path.each_with_index.all? do |element, index|
        if path[index+1]
          element2 = path[index+1]
          linked?(element, element2)
        else
          true
        end
      end
    end

    def find_finish
      y = matrix.index(@row_with_finish)
      x = @row_with_finish.index("F")
      [x, y]
    end

    def find_start
      y = matrix.index(@row_with_start)
      x = @row_with_finish.index("S")
      [x, y]
    end

    def correct_row(value)
      @landscape.matrix.find do |row|
        row.any? do |element|
          element == value
        end
      end
    end

    def linked?(first_position, second_position)
      first_position.any? do |element|
        one_x = element
        two_x = second_position[0]
        one_y = first_position[1]
        two_y = second_position[1]

        (one_x == two_x && (one_y - two_y).abs == 1) ||
          (one_y == two_y && (one_x - two_x).abs == 1)
      end
    end

    def matrix
      @landscape.matrix
    end
  end
