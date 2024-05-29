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
/*
import processing.sound.*; //also consider minim
 SoundFile sfile;
 */
int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

void setup() {
  size(200, 200);
  //File aud = new File("data/Short_Sway.wav"); //file not found??
  byte[] bytes = null;
  try {
    Path fPath = Paths.get("Short_Sway.wav");
    byte[] holder = Files.readAllBytes(fPath); //consider header bytes
    bytes = holder;
  } catch (Exception e){
    e.printStackTrace();
  }
  
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

ArrayList<Byte> decode(byte[] bytes) {
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
