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

void setup() {
  size(200, 200);
  byte[] bytes = loadBytes("Short_Sway.wav");
  
  ArrayList<Byte> messageArray = decode(bytes);
  System.out.println(messageArray.size());
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
    try (FileOutputStream output = new FileOutputStream("decrypted.dat")){
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
  while (value != (byte)255) { //terminating byte is 00000000 (tentatively)
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
