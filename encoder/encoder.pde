import java.lang.Byte;
import java.lang.String;
import java.lang.Integer;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import processing.sound.*;

int STRING = 0;
int IMG = 1;
int FILE = 2;
int MODE;

byte[] bytes;
String message;

String[] userInput;

void setup() {
  userInput = loadStrings("userInput.txt");
  if (userInput.length < 3) println("Invalid Input!!!");
  else {
    bytes = loadBytes(userInput[0]);
    String mode = userInput[1];
    println(userInput[0]);
    if(mode.equals("STRING")){
      MODE = STRING;
    }else if(mode.equals("IMG")){
      MODE = IMG;
    }else if(mode.equals("FILE")){
      MODE = FILE;
    }else{
      println("Invalid Mode!!!");
    }
    
    if (MODE == STRING) {
      println("STRING");
      message = userInput[2];
      byte[] msgByte = message.getBytes(StandardCharsets.UTF_8);   
      byte[] messageArray = encode(bytes, msgByte);
      saveBytes("encryptMsg.wav", messageArray);
    }else if (MODE == IMG) {
      println("IMG");
      byte[] fileBytes = loadBytes(userInput[2]);
      byte[] array = encode(bytes, fileBytes);
      saveBytes("encryptImg.wav", array);
    }else if (MODE == FILE) {
      println("FILE");
      byte[] fileBytes = loadBytes(userInput[2]);
      byte[] array = encode(bytes, fileBytes);
      saveBytes("encryptFile.wav", array);
    }
  }
  
}


//void encodeData(byte[] bytes, byte[] msgByte) {
//  for (int i = 0; i < msgByte.length; i++) {
//    for (int j = 0; j < 8; j++) {
//      int index = i * 8 + j;
//      int bit = (msgByte[i] >> (7 - j)) & 0x01;
//      bytes[index] = (byte)((bytes[index] & 0xFE) | bit);
//    }
//  }
  
//  println(msgByte.length*4);
//}

byte[] encode(byte[] bytes, byte[] msgByte) {
  int bi = 1024;
  for (int i = 0; i < msgByte.length; i++) {
    byte msgb = msgByte[i];
    
    byte seg1 = (byte) ((msgb >> 6) & 0b11);
    byte seg2 = (byte) ((msgb >> 4) & 0b11);
    byte seg3 = (byte) ((msgb >> 2) & 0b11);
    byte seg4 = (byte) (msgb & 0b11);

    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg1);
    bi += 4;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg2);
    bi += 4;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg3);
    bi += 4;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg4);
    bi += 4;
  }

  println(msgByte.length * 16);
  return bytes;
}


int[] fileToArray(String s){
  byte[] file = loadBytes(s);
  print(file.length);
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

  println(msgByte.length);
  return bytes;
}
