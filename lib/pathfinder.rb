class Pathfinder
  def initialize(landscape)
    @landscape = landscape
    @row_with_finish = correct_row("F")
    @row_with_start = correct_row("S")
  end

  def solve
    []
  end

  def valid_path
    valid_paths.first
  end

  def valid_paths
    permutations = 2
    solution = []
    until permutations == 3
     permutations += 1
     solution = @landscape.matrix_coordinates.permutation(permutations).to_a.select do |arrangement|
       arrangement.first == find_start && arrangement.last == find_finish && all_linked?(arrangement)
       print arrangement
     end
    end
    solution
  end

  def all_linked?(chance)
    chance.each_with_index.all? do |element, index|
      if chance[index+1]
        element2 = chance[index+1]
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
