import java.util.Arrays;
import java.io.*;
import processing.sound.*;
import ddf.minim.*;

SoundFile displayfile = new SoundFile(this, "Sway_to_My_Beat_in_Cosmos_Instrumental.wav");
SoundFile hiddenfile = new SoundFile(this, "WHITE_NIGHT_Instrumental.wav");

Minim minim;
AudioPlayer player;

int ultrasoundSI = 48000; //ultrasound start index
String secretMsg = "This is a secret message!";

float[] hiddenLeft = hiddenfile.left();

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

void setup() {
  size(200, 200);
    
  if (MODE == 0) {
    encodeMessage(displayfile, secretMsg);
  }else if (MODE == 1) {
  }else if (MODE == 2) {    
    encodeAudio(displayfile, hiddenfile);
  }
  
  displayfile.play();
}

void draw() {
}

void encodeMessage(SoundFile displayfile, String msg) {
  for (int i=0; i<20; i++) {
    println(displayfile.sampleRate());
  }
  
  //String[] binMsg = new String[msg.length()];
  //for (int i=0; i<msg.length(); i++) {
  //  char c = msg.charAt(i);
  //  binMsg[i] += String.format("%8s", Integer.toBinaryString(c));
  //}
}

void encodeAudio(SoundFile displayfile, SoundFile hiddenfile) {
  if (hiddenfile.frames() <= displayfile.frames() - ultrasoundSI) {
    
  }else println("Hidden file too large to embed.");
}
