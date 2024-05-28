import java.util.Arrays;
import java.lang.Byte;
import java.lang.Integer;
import java.lang.String;
import java.io.File;
import java.util.ArrayList;
import java.nio.charset.StandardCharsets;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
/*
import processing.sound.*; //also consider minim
 SoundFile sfile;
 */
int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

void setup() {
  size(200, 200);
  File aud = new File("Short_Sway.wav"); //file not found??
  //processing audio
  AudioInputStream stream = null;
  AudioFormat format = null;
  try {
    stream  = AudioSystem.getAudioInputStream(aud);
    format = stream.getFormat();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  //System.out.println(format);
  
  
  //decode
  if (MODE == 0) {
    System.out.println(decodeStr(aud));
  } else if (MODE == 1) {
    decodeImg(aud);
  } else {
  }
}

String decodeStr(File aud) {
  return "";
}

void decodeImg(File aud) {
  //
}
