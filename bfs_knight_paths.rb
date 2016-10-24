require_relative 'bfs_dfs_tree'
require 'byebug'

class KnightPathFinder
  def initialize start = [0, 1]
    @start = start
    @visited_positions = [start]
  end

  def self.valid_moves pos
    x, y = pos

    moves = []
    [1, -1].each do |i|
      [2, -2]. each do |j|
        moves << [i, j] << [j, i]
      end
    end

    moves.map!{|(i, j)| [x + i, y + j] }
    moves.select{|move| valid_pos?(move)}.uniq
  end

  def self.valid_pos? move
    x, y = move
    x.between?(0, 7) && y.between?(0, 7)
  end

  def new_move_positions pos
    new_moves = KnightPathFinder.valid_moves(pos)

    new_moves.reject! {|move| @visited_positions.include?(move)}
    @visited_positions += new_moves

    new_moves
  end

  def build_move_tree
      tree = [PolyTreeNode.new(@start)]

      tree.each do |parent|
        children = new_move_positions(parent.value)

        children.each do |move|
          child = PolyTreeNode.new(move)
          parent.add_child(child)
          tree << child
        end

      end
      tree
  end

  def find_path pos
    tree = build_move_tree
    target = tree.first.bfs(pos)
    trace_path_back(target)
  end

  def trace_path_back target
    path = []
    current = target

    until current.nil?
      path.unshift(current.value)
      current = current.parent
    end

    path
  end
end
