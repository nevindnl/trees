import java.util.*;

public class BST {
  Node root;

  public BST(Integer[] values) {
    if (values.length == 0) {
      throw new java.lang.Error("must have at least one value");
    }

    ArrayList<Integer> list = new ArrayList<Integer>(Arrays.asList(values));
    Collections.shuffle(list);

    root = new Node(list.get(0));
    for (Integer value: list.subList(1, list.size())) {
      add(value);
    }
  }

  public Integer add(Integer value) {
    _add(root, value);
    return value;
  }

  private Node _add(Node node, Integer value) {
    if (node == null) return new Node(value);

    if (value <= node.value) {
      node.left = _add(node.left, value);
    } else {
      node.right = _add(node.right, value);
    }

    return node;
  }

  public Integer delete(Integer value) {
    root = _delete(root, value);
    return value;
  }

  private Node _delete(Node node, Integer value) {
    if (node == null) return null;

    if (value < node.value) {
      node.left = _delete(node.left, value);
    } else if (value > node.value){
      node.right = _delete(node.right, value);
    } else {
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;

      node.value = _min(node.right);
      node.right = _delete_min(node.right);
    }

    return node;
  }

  private Integer _min(Node node) {
    if (node == null) return null;

    if (node.left == null) {
      return node.value;
    } else {
      return _min(node.left);
    }
  }

  private Node _delete_min(Node node) {
    if (node == null) return null;

    if (node.left == null) {
      node = node.right;
    } else {
      node.left = _delete_min(node.left);
    }

    return node;
  }

  public ArrayList<Node> traverse() {
    return _traverse(root);
  }

  private ArrayList<Node> _traverse(Node node) {
    if (node == null) return new ArrayList<Node>();

    ArrayList<Node> result = _traverse(node.left);
    result.addAll(new ArrayList<Node>(Arrays.asList(node)));
    result.addAll(_traverse(node.right));
    return result;
  }

  public Node bfs(Integer value) {
    ArrayList<Node> queue = new ArrayList<Node>(Arrays.asList(root));

    while (!queue.isEmpty()) {
      Node node = queue.remove(0);

      if (!(node.left == null)) queue.add(node.left);
      if (!(node.right == null)) queue.add(node.right);

      if (node.value == value) return node;
    }

    return null;
  }

  public Node dfs(Integer value) {
    return _dfs(root, value);
  }

  private Node _dfs(Node node, Integer value) {
    if (node == null || node.value == value) return node;

    if (value <= node.value) {
      return _dfs(node.left, value);
    } else {
      return _dfs(node.right, value);
    }
  }

  public void print() {
    ArrayList<ArrayList<Node>> levels = _getLevels();
    ArrayList<String> strings = new ArrayList<String>();

    strings.add(_levelToString(levels.get(0)));
    for (int i = 1; i < levels.size(); i++) {
	 strings.add(_branchesToString(i));

	 ArrayList<Node> level = levels.get(i);
	 strings.add(_levelToString(level));
    }

    for (String string: strings) {
	 System.out.println(string);
    }
  }

  private ArrayList<ArrayList<Node>> _getLevels() {
    ArrayList<ArrayList<Node>> levels = new ArrayList<ArrayList<Node>>();
    levels.add(new ArrayList<Node>(Arrays.asList(root)));
    levels.add(new ArrayList<Node>());

    int i = 0;
    int j = 0;
    while (!levels.get(i).isEmpty()) {
      Node node = levels.get(i).get(j);

	 if (node == null) continue;

      levels.get(i + 1).add(node.left);
      levels.get(i + 1).add(node.right);

	 j++;

      if (j == levels.get(i).size() && !levels.get(i + 1).isEmpty()) {
        i++;
        j = 0;
        levels.add(new ArrayList<Node>());
      }
    }

    levels.remove(levels.size() - 1);
    return levels;
  }

  private String _levelToString(ArrayList<Node> line) {
    ArrayList<String> result = new ArrayList<String>();

    for (Node node : line) {
      if (node == null) {
	   result.add("  ");
	 } else {
	   result.add(node.value + " ");
	 }
    }

    return String.join(" ", result);
  }

  private String _branchesToString(int i) {
    String[] result = new String[(int)Math.pow(2, i)];
    Arrays.fill(result, "/ \\");

    return String.join(" ", result);
  }
}
