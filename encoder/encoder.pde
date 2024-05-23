import java.util.Arrays;
import processing.sound.*;
SoundFile file;

int STRING = 0;
int IMG = 1;
int AUDIO = 2;
int MODE = 0;

void setup() {
  file = new SoundFile(this, "");
  file.play();
}

void draw() {
}
