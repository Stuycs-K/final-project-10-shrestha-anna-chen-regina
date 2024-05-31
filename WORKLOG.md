# Work Log

## GROUP MEMBER 1: Anna Shrestha

### Wed, 5/22

Start on outline of project(create branches, processing sketches) and begin researching implementation of audio steganography and file types. Notes/planning document: https://docs.google.com/document/d/1oLgrYbuv7iW_9uCib4jDbt9lGG-MdMGzmmYyTHb14_0/edit.

### Thu, 5/23

Do more research on Audacity (how to view frequency) and try to get encoded audio to test decoder. Look through Java's AudioSystem and Processing's Sound library. Outline of decode started, need to research bitrates/byte arrays/spectrograms.

### Fri, 5/24

Attempt to start decode using java's audio manipulation commands. Trying to change frequency to hide at inaudible frequencies and use least sig bit encoding but confused by bitrate and the number of bits in a second-which bit do we encode in?? Looking through AudioInputStream, FloatControl, and the Discrete/Fast Fourier Transform. Also researched pulse-code modulation (PCM) encoding --> lossless compression method (bitstream is lossy).

### Sun, 5/26

Start working on video script (background about audio steganography and spectrograms).

### Tue, 5/27

Did more research on lsb audio steganography, attempted to use Python's wav module to manipulate audio bytes. Realized we could use Files.readAllBytes(*Path*) to get bytes[]... We didn't need something specific to an audio file, and we can deal with frequency as an extra portion after we finish the rest. Decryption version 1 completed, tests needed to be run(find encrypting tools online).

### Wed, 5/29

Start testing decode (difficult without encode / terminating string). Steghide didn't have the terminating string so manually added it using hexdump. Moved to normal java file because Processing had file not found error. Realized loadBytes() was for all general files, and will be moving back into Processing and continuing tests.

### Thu, 5/30

Continue testing decode, had to manually create encrypted files since encoder was incomplete and online tools didn't have terminating digits or seemed to be working. However, by the end of class encoder was completed and normal testing can resume. Results were consistent with encrypted messages except the last letter which is missing, and didn't stop at the terminating value because it was not encrypted yet. Will consider creating a similar function for mp3 since it's easier to find mp3 files(header length differs). Also beginning testing on encrypted files(txt, png, wav) especially other audio files. Also looked over encode and tried to find the issue of encrypted audio missing half of the original audio length despite same number of bytes and proper header and tail (likely because of mp3 being lossy, wav files worked).

### Mon, 5/26

D


## GROUP MEMBER 2: Regina Chen

### Wed, 5/22

- Research on implementing audio files and manipulating it in processing.
- Started on encoding String into audio file, using .wav file extension.
- Added a .wav file into sketch for testing

### Thur, 5/23

- trying out the different methods in sound library
- trying out frames and channels to manipulate the ultrasound range for embedding another audio file
- playing around with audacity

### Fri, 5/24 to Mon 5/27
- looking through AudioInputStream and  Fast Fourier Transform
- tried using java but AudioInputStream gives error of "UnsupportedAudioFileException: File of unsupported format"
- trying to encode string to audio file using lsb but didn't find function to write the manipulated sample back to audio buffer

### Tue, 5/28
- starting a backup plan if encoding with frequency in audio files doesn't work
- start on and finish encoding columnar transposition cipher
- researching on how to decode columnar transposition cipher using brute force

### Wed, 5/29
- Encoding string into audio file works
- unable to hear sound from the encoded audio file but when opened on audacity, the frequency and everything else seem to be working fine
- might be due to header being manipulated so trying to fix
