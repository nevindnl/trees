# recursion
def balanced? root
end

def symmetric? root
end

def lca node1, node2
end

def has_path_sum? root, sum, path = [], current_sum = 0
  return current_sum == sum if root.children.empty?

  @children.any? do |child|
    has_path_sum?(child, sum, path + [root], current_sum + root.value)
  end
end

def has_path_sum? root, sum
  nodes = [root]

  # adds path, in case want to return path
  path = []
  current_sum = 0

  until nodes.empty?
    current = nodes.shift

    path.push(current)
    current_sum += current.value

    children = current.children

    if children.empty?
      return true if current_sum == sum
    else
      nodes = children + nodes
    end

    until path.last == nodes.first.parent
      current_sum -= path.pop.value
    end
  end

  false
end


# (binary)

# dfs is preorder traversal

def dfs root, target
  return root if root.value == target || root.nil?

  dfs(root.left) || dfs(root.right)
end

# with current
def dfs root, target
  nodes = []
  current = root

  until nodes.empty? && current.nil?
    if current
      return current if current.value == target

      nodes << current
      current = current.left
    else
      current = nodes.pop
      current = current.right
    end
  end

  nil
end

# without current
def dfs root, target
  nodes = [root]

  until nodes.empty?
    current = nodes.pop
    return current if current.value == target

    nodes += current.children.reverse
  end

  nil
end


# with current
def inorder root
  result = []
  nodes = []
  current = root

  until nodes.empty? && current.nil?
    if current
      nodes << current
      current = current.left
    else
      current = nodes.pop
      result << current
      current = current.right
    end
  end

  result
end

# without current
def inorder root
  result = []
  nodes = [root]

  until nodes.empty?
    current = nodes.last

    if current
      nodes << current.left
    else
      nodes.pop

      current = nodes.pop
      result << current
      nodes << current.right
    end
  end

  result
end

require 'set'

# with visited set, add all children
def inorder root
  result = []
  nodes = [root]
  visited = Set.new

  until nodes.empty?
    current = nodes.last

    if visited.include? current
      result << current
      nodes.pop
    else
      visited << current
      nodes += current.children.reverse
    end
  end

  result
end

def preorder root
  result = []
  nodes = [root]

  until nodes.empty?
    current = nodes.pop
    result << current

    nodes += current.children.reverse
  end

  result
end

def postorder root
  result = []
  nodes = [root]

  until nodes.empty?
    current = nodes.pop
    result.shift(current)

    nodes += current.children
  end

  result
end


# 2 pointers for O(1) space (with parent metadata)
