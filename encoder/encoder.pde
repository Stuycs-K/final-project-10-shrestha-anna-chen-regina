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
  size(600, 400);
  userInput = loadStrings("userInput.txt");
  if (userInput.length < 3) println("Invalid Input!!!");
  else {
    bytes = loadBytes(userInput[0]);
    for(int n = 0; n < 20; n++){
      print((int)bytes[n]+" ");
    }
    println(userInput[0]);
    MODE = Integer.parseInt(userInput[1]);
    
    if (MODE == 0) {
      println("0");
      message = userInput[2];
      byte[] msgByte = message.getBytes(StandardCharsets.UTF_8);   
      byte[] messageArray = encode(bytes, msgByte);
      saveBytes("encryptMsg.wav", messageArray);
    }else if (MODE == 1) {
      println("1");
      byte[] fileBytes = loadBytes(userInput[2]);
      byte[] array = encode(bytes, fileBytes);
      saveBytes("encryptImg.wav", array);
    }else if (MODE == 2) {
      println("2");
      byte[] fileBytes = loadBytes(userInput[2]);
      byte[] array = encode(bytes, fileBytes);
      /*println(" ");
      for(int n = 0; n < 20; n++){
        print((int)array[n]+" ");
      }
      println(" ");
      array = fileToArray(fileBytes,loadBytes(userInput[0]));
      for(int n = 0; n < 20; n++){
        print((int)array[n]+" ");
      }*/
      saveBytes("encryptFile.wav", array);
    }
  }
  
}

byte[] encode(byte[] bytes, byte[] msgByte) {
  int bi = 1024;
  for (int i = 0; i < msgByte.length; i++) {
    byte msgb = msgByte[i];
    
    byte seg1 = (byte) ((msgb >> 6) & 0b11);
    byte seg2 = (byte) ((msgb >> 4) & 0b11);
    byte seg3 = (byte) ((msgb >> 2) & 0b11);
    byte seg4 = (byte) (msgb & 0b11);

    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg1);
    bi += 2;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg2);
    bi += 2;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg3);
    bi += 2;
    bytes[bi] = (byte) ((bytes[bi] & 0b11111100) | seg4);
    bi += 2;
  }

  println(msgByte.length);
  return bytes;
}


byte[] fileToArray(byte[] input, byte[] audio){
  println(input.length);
  byte[] holder = new byte[input.length*4];
  
  for(int i = 0; i < input.length/4; i++){
    //print(file[i]+" ");
    boolean neg = false;
    if(input[i]<0){
      input[i] = (byte)(128+input[i]);
      neg = true;
    }
    for(int j = 1; j <= 4; j++){
      holder[(i+1)*4-j+1024] = (byte)(input[i]%4);
      input[i] = (byte)(input[i]/4);
      if(j==4&&neg){
        holder[(i+1)*4-j+1024] = (byte)(holder[(i+1)*4-j+1024]+2);
      }
    }
  }
  //print(holder.length+" "+audio.length);
  for(int i = 0; i < holder.length; i++){
    audio[2*i+1024] = (byte)(holder[i]+audio[2*i+1024]%4);
  }
  return audio;
}
