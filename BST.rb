class BSTNode
  attr_accessor :left, :right
  attr_accessor :value

  def initialize(value)
		@value = value
  end
end

class BinarySearchTree
  def initialize
		@root = nil
  end

  def insert(value)
		@root ? BinarySearchTree.insert!(@root, value) : @root = BSTNode.new(value)
  end

  def find(value)
		BinarySearchTree.find!(@root, value)
  end

	def inorder
    BinarySearchTree.inorder!(@root)
	end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
		return BSTNode.new(value) unless node

		if value <= node.value
			node.left = insert!(node.left, value)
		else
			node.right = insert!(node.right, value)
		end

		node
  end

  def self.find!(node, value)
		return node if !node || node.value == value

		child = value <= node.value ? node.left : node.right
		find!(child, value)
  end

  def self.preorder!(node)
		return [] unless node

		[node.value] + preorder!(node.left) + preorder!(node.right)
  end

  def self.inorder!(node)
		return [] unless node

		inorder!(node.left) + [node.value] + inorder!(node.right)
  end

  def self.postorder!(node)
		return [] unless node

		postorder!(node.left) + postorder!(node.right) + [node.value]
  end

  def self.height!(node)
		return -1 unless node

		[1 + height!(node.left), 1 + height!(node.right)].max
  end

  def self.max(node)
		return nil unless node

		node.right ? max(node.right) : node
  end

  def self.min(node)
		return nil unless node

		node.left ? min(node.left) : node
  end

  def self.delete_min!(node)
		return nil unless node

		if node.left
			node.left = delete_min!(node.left)
		else
			node = node.right
		end

		node
  end

  def self.delete!(node, value)
		return nil unless node

		if value < node.value
			node.left = delete!(node.left, value)
		elsif value > node.value
			node.right = delete!(node.right, value)
		else
			return node.left unless node.right
			return node.right unless node.left

			node.value = min(node.right)
			node.right = delete_min!(node.right)
		end

		node
  end
end
