import wave;

initial = wave.open("ShortSway.wav", mode='rb');
frequency = bytearray(initial.readframes(initial.getnframes()));

bytes = [];
end = false;
index = 0;
while end: #keep looking at lsb until terminating key 0000
    holder = byte(0);
    for i in range(0,4):
        holder = byte((holder << 2) + frequency[index]%2);
        System.out.print(holder<<2);
    bytes.append(holder);
    index = index+1;
    if holder==0:
        end = true;
Wave_read.close();
