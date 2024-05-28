import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup() {
  size(100, 100);
  
  minim = new Minim(this);
  
  // Load the original audio file
  player = minim.loadFile("Sway_to_My_Beat_in_Cosmos_instrumental.wav");
  
  // Encode the string into binary
  String message = "Hello, this is a hidden message!";
  String binaryMessage = stringToBinary(message);
  
  // Modify the audio data to hide the binary message
  encodeMessage(player, binaryMessage);
  
  // Save the modified audio file

  
  exit(); // Quit after saving the file
}

String stringToBinary(String text) {
  String binary = "";
  for (char c : text.toCharArray()) {
    binary += Integer.toBinaryString(c) + " ";
  }
  return binary;
}

void encodeMessage(AudioPlayer player, String binaryMessage) {
  int sampleCount = player.bufferSize();
  for (int i = 0; i < binaryMessage.length(); i++) {
    if (i < sampleCount) {
      int sample = (int) player.mix.get(i);
      // Modify the least significant bit of the sample
      if (binaryMessage.charAt(i) == '1') {
        sample |= 1;
      } else {
        sample &= ~1;
      }
      player.mix.set(i, sample);
    }
  }
}
