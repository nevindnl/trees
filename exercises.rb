# recursion
def balanced? root
end

def symmetric? root
end

def traversal
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
