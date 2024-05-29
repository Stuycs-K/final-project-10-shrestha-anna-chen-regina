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

    File aud = new File("Short_Sway.wav");
    byte[] bytes = null;
    try {
      Path fPath = Paths.get("Short_Sway.wav");
      byte[] holder = Files.readAllBytes(fPath); //consider header bytes
      bytes = holder;
    } catch (Exception e){
      e.printStackTrace();
    }

    ArrayList<Byte> messageArray = encode(bytes, msgByte);
    byte[] result = new byte[messageArray.size()-1]; //remove last terminating bit
    for(int i = 0; i < result.length; i++){
      result[i] = messageArray.get(i);
    }

    //decode
    if (MODE == 0) {
      //System.out.println(messageArray);
      String text = new String(result, StandardCharsets.UTF_8);
      System.out.println(text);
    } else if (MODE == 1) {
      try (FileOutputStream output = new FileOutputStream("decrypted.png")){
          output.write(result);
        }catch (IOException e){
          e.printStackTrace();
        }
    } else {
      try (FileOutputStream output = new FileOutputStream("decrypted.wav")){
          output.write(result);
        }catch (IOException e){
          e.printStackTrace();
        }
    }

  }

  public static ArrayList<Byte> encode(byte[] bytes, bytes[] msgByte) {
    ArrayList<Byte> result = new ArrayList<Byte>();
    byte value = 0;
    int n = 0;
    while (value != (byte)0) { //terminating byte is 00000000 (tentatively)
      value = 0;
      for(int i = 0; i < 4; i++){
        value = (byte)(value*4 + bytes[n*4+i]%4);
        //println(bytes[n*4+i]%4+"+"+value*4+"="+value);
      }
      result.add(value);
      n++;
    }

    return result;
  }

}
