import java.util.*;

public class Main {
  public static void main(String[] args) {
    System.out.println("BST");
    System.out.println("-----");

    int length = 30;
    // 1 <= init_length <= length
    int init_length = 3;
    int limit = 40;
    int searches = 5;
    int deletes = 20;

    // generate random values
    Integer[] values = new Integer[length];
    for (int i = 0; i < length; i++) {
      values[i] = (int)(Math.random() * limit);
    }

    // initialize tree
    Integer[] init = Arrays.copyOfRange(values, 0, init_length);
    System.out.println("initializing with " + Arrays.toString(init));
    BST bst = new BST(init);
    bst.print();
    System.out.println("--------------------");

    // add rest of the values
    for (Integer value : Arrays.copyOfRange(values, init_length, length)) {
      System.out.println("adding " + value);
      bst.add(value);
    }
    bst.print();
    System.out.println("--------------------");

    // search for random values
    for (int i = 0; i < searches; i++) {
      Integer value = (int)(Math.random() * limit);
      System.out.println("bfs for " + value);
      Node result = bst.bfs(value);
      System.out.println(result == null ? null : result.value);
      System.out.println("dfs for " + value);
      result = bst.dfs(value);
      System.out.println(result == null ? null : result.value);
    }
    System.out.println("--------------------");

    // delete values
    for (int i = 0; i < deletes; i++) {
      Integer value = values[(int)(Math.random() * length)];
      System.out.println("deleting " + value);
      bst.delete(value);
    }
    bst.print();
    System.out.println("--------------------");
  }
}
