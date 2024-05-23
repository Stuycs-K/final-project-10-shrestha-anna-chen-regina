import java.util.Arrays;
import processing.sound.*;
SoundFile sfile;
String secretMsg = "This is a secret message!";

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

void setup() {
  size(200, 200);
  
  if (MODE == 0) {
  sfile = new SoundFile(this, "Sway_to_My_Beat_in_Cosmos_instrumental.wav");
  encodeMessage(sfile, secretMsg);
  }
  
  sfile.play();
}

void draw() {
}

void encodeMessage(SoundFile sfile, String msg) {
  for (int i=0; i<20; i++) {
    println(sfile[i].sampleRate());
  }
  
  //String[] binMsg = new String[msg.length()];
  //for (int i=0; i<msg.length(); i++) {
  //  char c = msg.charAt(i);
  //  binMsg[i] += String.format("%8s", Integer.toBinaryString(c));
  //}
}
