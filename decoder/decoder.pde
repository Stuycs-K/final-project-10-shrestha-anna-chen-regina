import java.lang.Byte;
import java.lang.String;
import java.lang.Integer;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 1;

void setup() {
  size(200, 200);
  String[] input = loadStrings("userinput.txt");
  if(input.length!=3){
    print("Invalid input format!");
  }else{
    byte[] bytes = loadBytes(input[0]);
    MODE = Integer.parseInt(input[1]);
    int count = Integer.parseInt(input[2]);
    
    ArrayList<Byte> messageArray = decode(bytes,count);
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
}

ArrayList<Byte> decode(byte[] bytes,int count) {
  ArrayList<Byte> result = new ArrayList<Byte>();
  byte value = 0;
  
  for(int n = 0; n < count/4; n++){
    value = 0;
    for(int i = 0; i < 4; i++){
      value = (byte)(value*4 + bytes[n*4+i+1024]%4); //ignores byte header
      //println(bytes[n*4+i]%4+"+"+value*4+"="+value);
    }
    result.add(value);
  }

  return result;
}
