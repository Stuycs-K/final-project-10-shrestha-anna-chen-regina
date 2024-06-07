# LSB (least significant bit) Audio Steganography With Wav Files
the information hider embeds the secret information in the least significant bits of a media file which in our case is audio files
## Basic structure of an audio file
- Header: format of audio file (mp3, wav, m4a, etc) and how these data are stored
  - the sample rate, number of channels (mono or stereo), and 
  - Metadata: title of song and album, artist names, track number, cover art, etc
- Audio data:
  - Uncompressed format: audio data are stored in a series of audio samples where each sample represents the amplitude of the audio signal at a specific point in time. It's lossless which means that manipulating the file (converting or compressing) will make it experience negligible loss in sound quality
  - Compressed format: audio data are stored in frames, which contain the audio samples. Each frame includes a header with information about the frame length, bit rate, and sample rate, followed by the compressed audio data. These frames often include error detection or correction data to ensure integrity.

## How our program works:
Remember how we use the least significant bit of the red byte in the rgb of the pixels in class to hide messages and other files 
Our program is similar to that but instead of using pixels, we’re using the actual bytes of the audio file, just like how we would access bytes in regular text files.

Our program uses wav files since wav files are uncompressed and so it's easier to modify. In addition, since uncompressed files are loseless, the sound 
First, we will need to skipped the header section so that we’re directly manipulating the audio data 
