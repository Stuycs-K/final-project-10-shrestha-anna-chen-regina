import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
/*
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;*/

public class decode{
  static int STRING = 0;
  static int IMG = 1;
  static int AUDIO = 2;
  static int MODE = STRING;

  public static void main(String[] args) {
    //File aud = new File("data/Short_Sway.wav"); //file not found??
    byte[] bytes = new byte[1];
    try {
      Path fPath = Paths.get("5mb.wav");
      byte[] holder = Files.readAllBytes(fPath); //consider header bytes(first 44)
      /*for(int i = 0; i < holder.length; i++){
        bytes[i] = holder[i+44];
      }*/
      bytes = holder;
    } catch (Exception e){
      e.printStackTrace();
      System.out.println("file not found");
    }
    //System.out.println(bytes.length);

    /*//processing audio
    AudioInputStream stream = null;
    AudioFormat format = null;
    try {
      stream  = AudioSystem.getAudioInputStream(aud);
      format = stream.getFormat();
    }catch (Exception e) {
      e.printStackTrace();
    }
    //System.out.println(format);*/

    ArrayList<Byte> messageArray = decode(bytes);
    //System.out.println(messageArray.size());
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
      try (FileOutputStream output = new FileOutputStream("decrypted.txt")){
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

  public static ArrayList<Byte> decode(byte[] bytes) {
    ArrayList<Byte> result = new ArrayList<Byte>();
    byte value = 0;
    int n = 0;
    while (value != (byte)10 && n<bytes.length) { //terminating byte is 00000000 (tentatively)
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
