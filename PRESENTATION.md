# LSB (least significant bit) Audio Steganography With Wav Files
## Basic structure of an audio file
- Header: format of audio file (mp3, wav, m4a, etc) and how these data are stored
  - the sample rate, number of channels (mono or stereo), byte rate, etc
  - Metadata: title of song and album, artist names, track number, cover art, etc
- Audio data:
  - Uncompressed format: audio data are stored in a series of audio samples where each sample represents the amplitude of the audio signal at a specific point in time. It's lossless which means that manipulating the file (converting or compressing) will make it experience negligible loss in sound quality
  - Compressed format: audio data are stored in frames, which contain the audio samples. Each frame includes a header with information about the frame length, bit rate, and sample rate, followed by the compressed audio data. These frames often include error detection or correction data to ensure integrity.

## Mono/Stereo Sound files
- Mono: only has one channel</br>
<img width="763" alt="Screenshot 2024-06-08 at 4 17 22 PM" src="https://github.com/Stuycs-K/final-project-10-shrestha-anna-chen-regina/assets/112907876/9f24ac49-792f-4b88-b287-35b5c7552d94">
- Stereo: two channels, a left channel and a right channel

## How our program generally works:
- wav files: audio data stored in uncompressed format
- skip header
- manipulate the least significant bit of the bytes in the audio data only
- change only the least significant bit of every other byte

