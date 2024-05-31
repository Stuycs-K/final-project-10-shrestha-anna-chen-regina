import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 1;

byte[] bytes;
String message;

void setup() {
  size(200, 200);
  bytes = loadBytes("Sway_to_My_Beat_in_Cosmos_instrumental.wav");
  
  if (MODE == 0) {
    message = "hello world";
    byte[] msgByte = message.getBytes(StandardCharsets.UTF_8);   
    byte[] messageArray = encode(bytes, msgByte);
    saveBytes("encryptMsg.mp3", messageArray);
  }else if (MODE == 1) {
    byte[] fileBytes = loadBytes("cat.png");
    byte[] array = encode(bytes, fileBytes);
    saveBytes("encryptFile.mp3", array);
    //encodeData(bytes, fileBytes);
    saveBytes("encryptFile.wav", bytes);
  }else if (MODE == 2) {
    
  }
  
}

//void encodeData(byte[] audioBytes, byte[] data) {
//  for (int i = 0; i < data.length; i++) {
//    for (int j = 0; j < 8; j++) {
//      // Embed each bit of data into the least significant bit of each audio sample
//      int audioIndex = i * 8 + j;
//      int dataBit = (data[i] >> (7 - j)) & 0x01;
//      audioBytes[audioIndex] = (byte)((audioBytes[audioIndex] & 0xFE) | dataBit);
//    }
//  }
//}

byte[] encode(byte[] bytes, byte[] msgByte) {
  int bi = 46;
  for (int i=0; i<msgByte.length; i++) {
    byte msgb = msgByte[i];

    byte seg1 = (byte) ((msgb >> 6) & 0b11);
    byte seg2 = (byte) ((msgb >> 4) & 0b11);
    byte seg3 = (byte) ((msgb >> 2) & 0b11);
    byte seg4 = (byte) (msgb & 0b11);

    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg1);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg2);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg3);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg4);
  }
  //bytes[bi] = (byte)255;
  
  println(msgByte.length*4);
  return bytes;
}
