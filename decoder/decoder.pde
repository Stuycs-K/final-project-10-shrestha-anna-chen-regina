import java.lang.Byte;
import java.lang.String;
import java.lang.Integer;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 1;

void setup() {
  size(200, 200);
  byte[] bytes = loadBytes("encryptFile.wav");
  //System.out.println(Integer.toBinaryString(bytes[0])+" "+Integer.toBinaryString(bytes[1]));
  
  ArrayList<Byte> messageArray = decode(bytes);
  //System.out.println(messageArray.size());
  byte[] result = new byte[messageArray.size()];
  for(int i = 0; i < result.length; i++){
    result[i] = messageArray.get(i);
  }
  
  //decode
  if (MODE == 0) {
    //System.out.println(messageArray);
    String text = new String(result, StandardCharsets.UTF_8);
    System.out.println(text);
  } else {
    saveBytes("decrypted.png", result);
  }
}

ArrayList<Byte> decode(byte[] bytes) {
  ArrayList<Byte> result = new ArrayList<Byte>();
  byte value = 0;
  
  for(int n = 0; n < 583500; n++){
    value = 0;
    for(int i = 0; i < 4; i++){
      value = (byte)(value*4 + bytes[n*4+i+1024]%4); //ignores byte header
      //println(bytes[n*4+i]%4+"+"+value*4+"="+value);
    }
    result.add(value);
  }

  return result;
}
