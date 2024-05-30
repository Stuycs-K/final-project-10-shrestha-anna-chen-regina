public class decode {

  public static void main(String[]args) {
    String cipher = "LOAEWDLRBHOL";
    String key = "3241";

    String decipher = decodeWK(cipher, key);
    System.out.println(decipher);
  }

  public static String decodeWK(String cipher, String key) {
    int col = key.length();
    int r
    String decipher = "";



    return decipher;
  }

  public static String decodeNK(String cipher, String key) {
    String decipher = "";
    return decipher;
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
