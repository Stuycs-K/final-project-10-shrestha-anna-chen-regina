import java.lang.Byte;
import java.lang.String;
import java.lang.Integer;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
int STRING = 0;
int IMG = 1;
int FILE = 2;
int MODE = 2;

void setup() {
  size(200, 200);
  String[] input = loadStrings("userinput.txt");
  if(input.length!=3){
    print("Invalid input format!");
  }else{
    println(input[0]);
    println(input[1]);
    byte[] bytes = loadBytes(input[0]);
    MODE = Integer.parseInt(input[1]);
    int count = Integer.parseInt(input[2]);
    /*for(int n = 0; n < 20; n++){
      print((int)bytes[n]+" ");
    }
    println(" ");*/
    
    byte[] result = decode(bytes,count);
    //System.out.println(result.length);
    
    //decode
    if (MODE == 0) {
      //System.out.println(messageArray);
      String text = new String(result, StandardCharsets.UTF_8);
      System.out.println(text);
    } else if (MODE == 1){
      saveBytes("decrypted.png", result);
      System.out.println("decrypted.png");
    } else {
      saveBytes("decrypted.dat", result);
      System.out.println("decrypted.dat");
      System.out.println("Manual file conversion needed.");
    }
  }
}

byte[] decode(byte[] bytes, int count) {
  byte[] result = new byte[count];
  
  for(int n = 0; n < count; n++){
    byte value = bytes[n*8+1024];
    for(int i = 1; i < 4; i++){
      value = (byte)(value*4 + bytes[n*8+2*i+1024]%4); //+1024 ignores file headers
      //println(bytes[n*8+2*i+1024]%4+"+"+value*4+"="+value);
    }
    result[n] = value;
    /*if(n < 20){
      print((int)result[n]+" ");
    }*/
  }
  //println(" ");
  return result;
}
