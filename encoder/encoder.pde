import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;


public class Encoder {

  public static void main(String[] args) {
    int STRING = 0;
    int IMG = 1;
    int AUDIO = 2;
    int MODE = 0;

    String message = "hello world";
    byte[] msgByte = message.getBytes();
    System.out.println("String to byte array: " + Arrays.toString(msgByte));

    File aud = new File("Sway_to_My_Beat_in_Cosmos_instrumental.wav");
    byte[] bytes = null;
    try {
      Path fPath = Paths.get("Sway_to_My_Beat_in_Cosmos_instrumental.wav");
      bytes = Files.readAllBytes(fPath); //consider header bytes
    } catch (Exception e){
      e.printStackTrace();
    }

    byte[] messageArray = encode(bytes, msgByte);

    try (FileOutputStream output = new FileOutputStream("encrypt.wav")){
      output.write(messageArray);
    }catch (IOException e){
      e.printStackTrace();
    }

  }

  public static byte[] encode(byte[] bytes, byte[] msgByte) {
    int bi = 0;
    for (int i=0; i<msgByte.length; i++) {
      byte msgb = msgByte[i];

      byte seg1 = (byte) ((msgb >> 6) & 0b11);
      byte seg2 = (byte) ((msgb >> 4) & 0b11);
      byte seg3 = (byte) ((msgb >> 2) & 0b11);
      byte seg4 = (byte) (msgb & 0b11);

      bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg1);
      System.out.println("b1: " + bytes[bi-1]);
      bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg2);
      System.out.println("b2: " + bytes[bi-1]);
      bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg3);
      System.out.println("b3: " + bytes[bi-1]);
      bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg4);
      System.out.println("b4: " + bytes[bi-1]);
    }

    return bytes;
  }

}
