public class Encode {

  public static void main(String[] args) {
    String message = "hello world";

    String encodeMsg = encode(message, 3, 4);

  }

  public static String encode(String msg, int row, int col) {
    char[][] ary = new char[row][col];
    int r = 0;
    int c = 0;
    for (int i=0; i<msg.length(); i++) {
      char[r][c] = msg.charAt(i);
      c = (c + 1) % 4;
      if (c == 0) r++;
    }
    r = 0;
    c = 0;


  }

  public static void printAry(char[][] ary) {
    
  }

}
