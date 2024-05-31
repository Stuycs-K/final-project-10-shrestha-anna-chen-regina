import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import processing.sound.*;

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
    byte[] messageArray = encode(bytes, msgByte);
    saveBytes("encryptMsg.mp3", messageArray);
    
    //encodeData(bytes, msgByte);
    //saveBytes("encryptMsg.mp3", bytes);
  }else if (MODE == 1) {
    byte[] fileBytes = loadBytes("cat.png");
    byte[] array = encode(bytes, fileBytes);
    saveBytes("encryptFile.mp3", array);
    
    //encodeData(bytes, fileBytes);
    //saveBytes("encryptFile.mp3", bytes);
  }else if (MODE == 2) {
    
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
  int bi = 46;
  for (int i=0; i<msgByte.length; i++) {
    byte msgb = msgByte[i];

    //byte seg1 = (byte) ((msgb >> 6) & 0b11);
    //byte seg2 = (byte) ((msgb >> 4) & 0b11);
    //byte seg3 = (byte) ((msgb >> 2) & 0b11);
    //byte seg4 = (byte) (msgb & 0b11);

    //bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg1);
    //bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg2);
    //bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg3);
    //bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg4);
    
    byte seg1 = (byte) ((msgb >> 7) & 0b01);
    byte seg2 = (byte) ((msgb >> 6) & 0b01);
    byte seg3 = (byte) ((msgb >> 5) & 0b01);
    byte seg4 = (byte) ((msgb >> 4) & 0b01);
    byte seg5 = (byte) ((msgb >> 3) & 0b01);
    byte seg6 = (byte) ((msgb >> 2) & 0b01);
    byte seg7 = (byte) ((msgb >> 1) & 0b01);
    byte seg8 = (byte) (msgb & 0b01);

    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg1);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg2);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg3);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg4);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg5);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg6);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg7);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111110) | seg8);
  }
  //bytes[bi] = (byte)255;
  
  println(msgByte.length*8);
  return bytes;
}
