class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent= parent
    @parent.children.reject! { |child| child == self } unless @parent == nil
    @parent = parent
    parent.children << self unless parent == nil
  end

  def add_child(child)
    child.parent= self
  end

  def remove_child(child)
    raise 'not child.' if child.parent != self
    child.parent = nil
  end

  def dfs target_value
    return self if @value == target_value
    @children.each do |node|
      child_dfs = node.dfs(target_value)
      return child_dfs unless child_dfs == nil
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current = queue.shift
      queue += current.children
      return current if current.value == target_value
    end
    nil
  end
end
