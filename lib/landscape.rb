class Landscape
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.load(file_path)
    matrix = File.open(file_path) do |file|
              file.each_line.map do |line|
                line.chomp!.split(//)
              end
            end
    self.new(matrix)
  end

  def to_s
    matrix.map { |l| l.join("") }.join("\n")
  end

  def start
    element_coords("S")
  end

  def finish
    element_coords("F")
  end

  def element_coords(element)
    row = matrix.find { |f| f.include?(element) }
    y = matrix.index(row)
    x = row.index(element)
    [x,y]
  end

  def matrix_coordinates
    coordinate_matrix = matrix.map.with_index do |row, y|
      row.map.with_index do |element, x|
        [x, y]
      end
    end
    add_together(coordinate_matrix)
  end

  def add_together(coordinate_matrix)
    coordinate_matrix.inject(:+)
  end


  def value(array)
    x,y = array
    matrix[y][x]
  end
end
