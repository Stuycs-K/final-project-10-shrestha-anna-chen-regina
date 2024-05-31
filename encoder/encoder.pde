import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import processing.sound.*;

AudioSample audioSample;

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 1;

byte[] bytes;
String message;

void setup() {
  size(200, 200);
  bytes = loadBytes("Sway_to_My_Beat_in_Cosmos_instrumental.mp3");
  
  if (MODE == 0) {
    message = "hello world";
    byte[] msgByte = message.getBytes(StandardCharsets.UTF_8);   
    //byte[] messageArray = encode(bytes, msgByte);
    //saveBytes("encryptMsg.mp3", messageArray);
    encodeData(bytes, msgByte);
    saveBytes("encryptMsg.mp3", bytes);
  }else if (MODE == 1) {
    //byte[] array = encode(bytes, fileBytes);
    //saveBytes("encryptFile.mp3", array);
    byte[] fileBytes = modify(bytes,fileToArray("cat.png"));
    saveBytes("encryptFile.mp3", bytes);
  }else if (MODE == 2) {
    
  }
  
}

void encodeData(byte[] bytes, byte[] msgByte) {
  for (int i = 0; i < msgByte.length / 4; i++) {
    for (int j = 0; j < 8; j++) {
      int index = i * 8 + j;
      int bit = (msgByte[i] >> (7 - j)) & 0x01;
      bytes[index] = (byte)((bytes[index] & 0xFE) | bit);
    }
  }
}

int[] fileToArray(String s){
  byte[] file = loadBytes(s);
  int[] parts = new int[file.length*4];
  
  for(int i = 0; i < file.length; i++){
    //print(file[i]+" ");
    boolean neg = false;
    if(file[i]<0){
      file[i] = (byte)(128+file[i]);
      neg = true;
    }
    for(int j = 1; j <= 4; j++){
      parts[(i+1)*4-j] = file[i]%4;
      file[i] = (byte) (file[i]/4);
      if(j==4&&neg){
        parts[(i+1)*4-j] = (byte)(parts[(i+1)*4-j]+2);
      }
    }
  }
  print(parts.length);
  return parts;
}

byte[] modify(byte[] audio, int[]messageArray){
  byte[] ret = new byte[audio.length];
  for (int i = 0; i < messageArray.length; i++) {
    //System.out.println(img.pixels[i]);
    /*if(i<16){
      println(messageArray[i]%4+"+"+(red(img.pixels[i])/4)*4);
      println(red(img.pixels[i])+" vs "+(int)(red(img.pixels[i]))/4*4);
    }*/
    ret[i] = byte(messageArray[i]%4+(int)(audio[i+4])/4*4);
    /*if(i<16){
      println(red(img.pixels[i]));
    }*/
  }
  return ret;
}
