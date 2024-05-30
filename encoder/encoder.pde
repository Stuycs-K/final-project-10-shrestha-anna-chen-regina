import java.lang.Byte;
import java.lang.String;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

String message;

void setup() {
  size(200, 200);
  byte[] bytes = loadBytes("Sway_to_My_Beat_in_Cosmos_instrumental.mp3");
  
  message = "hello world";
  
  byte[] msgByte = message.getBytes();   
  System.out.println("String to byte array: " + Arrays.toString(msgByte));

  byte[] messageArray = encode(bytes, msgByte);

  saveBytes("encrypt.mp3", messageArray);
}

byte[] encode(byte[] bytes, byte[] msgByte) {
  int bi = 4;
  for (int i=0; i<msgByte.length; i++) {
    byte msgb = msgByte[i];

    byte seg1 = (byte) ((msgb >> 6) & 0b11);
    byte seg2 = (byte) ((msgb >> 4) & 0b11);
    byte seg3 = (byte) ((msgb >> 2) & 0b11);
    byte seg4 = (byte) (msgb & 0b11);

    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg1);
    //println("b1: " + bytes[bi-1]);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg2);
    //println("b2: " + bytes[bi-1]);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg3);
    //println("b3: " + bytes[bi-1]);
    bytes[bi] = (byte) ((bytes[bi++] & 0b11111100) | seg4);
    //println("b4: " + bytes[bi-1]);
  }

  return bytes;
}
