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
    byte[] msgByte = message.getBytes();   
    byte[] messageArray = encode(bytes, msgByte);
    saveBytes("encryptMsg.wav", messageArray);
  }else if (MODE == 1) {
    byte[] imgBytes = loadBytes("cat.png");
    byte[] array = encode(bytes, imgBytes);
    saveBytes("encryptImg.wav", array);
  }else if (MODE == 2) {
    
  }
  
}

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
