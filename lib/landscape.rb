class Landscape
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
    @matrix = parse_matrix
  end

  def size
    [matrix.first.length, matrix.count].max
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

  def parse_matrix
    #split_matrix = matrix_split
    #coords = add_together(split_matrix)
    build_matrix
    discount_obstacles
  end

  def discount_obstacles
    @matrix.delete_if do |key, value|
      value == "#" || value == "G"
    end
  end

  def build_matrix
    @matrix = matrix.each_with_object(Hash.new(0)) do |row, hashy|
      row.map.with_index do |value, index|
        hashy[[matrix.index(row), index]] = value
      end
    end
  end

  def matrix_split
    matrix.map.with_index do |row, y|
      row.map.with_index do |element, x|
        [x, y]
      end
    end
  end

  def add_together(coordinate_matrix)
    coordinate_matrix.inject(:+)
  end


  def value(array)
    x,y = array
    matrix[y][x]
  end
end
