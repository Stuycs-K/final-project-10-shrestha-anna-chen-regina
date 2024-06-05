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
  String[] input = loadStrings("userinput.txt");
  if(input.length!=3){
    print("Invalid input format!");
  }else{
    println(input[0]);
    String mode = input[1];
    println(mode);
    if(mode.equals("STRING")){
      MODE = STRING;
    }else if(mode.equals("IMG")){
      MODE = IMG;
    }else if(mode.equals("MODE")){
      MODE = FILE;
    }else{
      println("Invalid mode: "+mode);
    }
    
    byte[] bytes = loadBytes(input[0]);
    int count = Integer.parseInt(input[2]);
    /*for(int n = 0; n < 20; n++){
      print((int)bytes[n]+" ");
    }
    println(" ");*/
    
    byte[] result = decode2(bytes,count);
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

byte[] decode2(byte[] bytes, int count){
  byte[] holder = new byte[count];
  for (int i = 0; i < count; i++) {
    byte value = (byte) 0;

    for(int n = 0; n < 4; n++){
      value += (byte) ((bytes[1024+2*n+8*i] & 0b11) << 2*(3-n));
    }
    
    holder[i] = value;
    /*if(i < 20){
      print((int)holder[i]+" ");
    }*/
  }
  //println(" ");
  return holder;
}
