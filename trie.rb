class Node
  attr_accessor :value, :children, :parent, :contacts
  def initialize value
    @value = value
    @parent = nil
    @children = {}
    @contacts = []
  end
  def add_child node
    @children[node.value] = node
    node.parent = self
  end
end

class Trie
  attr_accessor :root
  def initialize
    @root = Node.new('')
  end

  def build_tree contacts
    contacts.each do |contact|
      add contact
    end
  end

  def add contact
    substrings = []
    contact.values.each do |word|
      substrings += substrings(word)
    end
    substrings.each do |substring|
      add_path substring, contact
    end
  end

  def add_path string, contact
    current = @root
    string.each_char do |c|
      node = current.children[c]
      unless node
        node = Node.new(c)
        current.add_child node
      end
      current = node
      current.contacts << contact['name']
    end
  end

  def search query
    current = @root
    query.each_char do |c|
      return [] unless current.children[c]
      current = current.children[c]
    end
    current.contacts
  end

  private

  def substrings word
    substrings = []
    word.length.times do |i|
      word.length.times do |j|
        substrings << word[i..j]
      end
    end
    substrings
  end
end

CONTACTS = JSON.parse(File.read('contacts.json'))
TREE = Trie.new()
TREE.build_tree CONTACTS

def search_contacts(query)
  # possible_contacts = contacts.select do |contact|
  #   contact["name"] && contact["name"].include?(query)
  # end
  # possible_contacts.map {|possible_contact| possible_contact["name"] }
  TREE.search query
end
