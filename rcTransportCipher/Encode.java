public class Encode {

  public static void main(String[] args) {
    String message = "hello world";

    String encodeMsg = encode(message, 3, 4);

  }

  public static String encode(String msg, int row, int col) {
    String encodeMsg = "";
    char[][] ary = new char[row][col];

    int r = 0;
    int c = 0;
    for (int i=0; i<msg.length(); i++) {
      if (msg.charAt(i) != ' ') {
        ary[r][c] = Character.toUpperCase(msg.charAt(i));
        c = (c + 1) % 4;
        if (c == 0) r++;
      }
    }

    char alphabet = 'A' - 1;
    while (c < col) {
      ary[r][c++] = (char)(((alphabet - 'A' + 1) % 26) + 'A');
    }

    printAry(ary);

    r = 0;
    c = 0;

    return encodeMsg;
  }

  public static void printAry(char[][] ary) {
    for (int r=0; r<ary.length; r++) {
      for (int c=0; c<ary[0].length; c++) {
        System.out.print(ary[r][c] + " ");
      }
      System.out.println("");
    }
  }

}
