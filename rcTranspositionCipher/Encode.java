public class Encode {

  public static void main(String[] args) {
    String message = "hello world";
    String key = "3241";

    String encodeMsg = encode(message, key);
    System.out.println(encodeMsg);

  }

  public static String encode(String msg, String key) {
    int col = key.length();
    int row = (msg.length() / col);
    if (row * col < msg.length()) row++;
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
      alphabet++;
    }

    // printAry(ary);

    for (int i=0; i<col; i++) {
      r = 0;
      int keyc = key.charAt(i) - '0';
      while (r < row) encodeMsg += ary[r++][keyc-1];
    }

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
