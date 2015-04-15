gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require_relative '../lib/landscape'
require_relative '../lib/pathfinder'

describe Pathfinder do
  before do
    @landscape  = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    @landscape2 = Landscape.load(File.join(__dir__, "fixtures", "landscape2.txt"))
    @landscape3 = Landscape.load(File.join(__dir__, "fixtures", "landscape3.txt"))
    @landscape4 = Landscape.load(File.join(__dir__, "fixtures", "landscape4.txt"))
  end

  it "finds the coordinate of the finished mark" do
    pathfinder = Pathfinder.new(@landscape3)
    solution =[2,1]
    assert_equal solution, pathfinder.find_finish
  end

  it "finds the coordinate of the start mark" do
    pathfinder = Pathfinder.new(@landscape3)
    solution =[1,1]
    assert_equal solution, pathfinder.find_start
  end

  it "has a linked? method" do
    pathfinder = Pathfinder.new(@landscape3)
    assert_equal true, pathfinder.linked?([1,1],[2,1])
    assert_equal false, pathfinder.linked?([1,1],[2,2])
    assert_equal true, pathfinder.linked?([1,1],[1,2])
    assert_equal false, pathfinder.linked?([1,1],[1,5])
    assert_equal true, pathfinder.linked?([4,5],[4,6])
    assert_equal true, pathfinder.linked?([0,0],[1,0])
    assert_equal false, pathfinder.linked?([0,0],[1,1])
    assert_equal false, pathfinder.linked?([1,1],[0,0])
    assert_equal false, pathfinder.linked?([1,1],[5,2])
    assert_equal false, pathfinder.linked?([1,1],[5,1])
  end

  it "returns a valid path start to finish 0 away" do
    pathfinder = Pathfinder.new(@landscape3)
    assert_equal [[[1,1], [2,1]]], pathfinder.valid_paths
  end

  it "returns a valid path for start to finish 1 away" do
    pathfinder = Pathfinder.new(@landscape4)
    assert_equal [[1,1], [2,1], [3,1]], pathfinder.valid_path
  end
end





describe "#solve" do
  it "returns a path as an array of coordinates" do
    skip
    solution = [[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1],
                [9,2],[9,3],[9,4],[9,5],[8,5],[7,5],[7,6],
                [7,7],[7,8],[7,9]]
    assert_equal solution, @pathfinder.solve(@landscape)
  end

  it "Solves with grass" do
    skip
    solution = [[3,4],[3,5],[4,5],[5,5],[6,5],[7,5],[8,5],
                [9,5],[10,5],[11,5],[12,5],[13,5],[14,5],
                [15,5],[16,5],[16,4]]
    assert_equal solution, @pathfinder.solve(@landscape2)
  end
end

