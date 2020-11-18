# Problem Set 7: TTS
For this problem set, you will **choose _*one*_ of the following two activities**.

1. Build a parametric TTS system using your own voice. This involves less programming but lots of unix and following directions very carefully. If you are a Windows user, I recommend not trying this option since I won't be able to provide technical support.

2. Write a program to turn the prosody of a statement into the prosody of a question. This involves more programming and not much unix or following directions.  

The deliverables for the two activities are described below. You will submit add, commit, and push the deliverables by the deadline, Tuesday, November 24, at 11:59pm.

## Activity 1: Building a TTS system with your own voice
Make this work will be complicated, but you won't need to do any actual programming. If you are good with unix, you will be able to finish this in less than an hour. If you are not good with unix, or if you are running Windows, I recommend trying activity #2.

### Step 1: Install Festival
1. Install the `sox` binary for your OS from here:

https://sourceforge.net/projects/sox/files/sox/14.3.2/

2. Open a terminal and navigate into this repo directory. Then issue the following commands, **one by one**.

```
cd ttsvoice
chmod +x fest_build.sh
./fest_build.sh
```

There will be a lot of output including lots of warning and even some "errors" that aren't actually errors. The final lines of the build output should look something like this.

```
making in src/mllr ...
g++ -Wall -o mllr mllr.cc making in src/spamf0 ... 
making in src/phrasyn ... 
making in src/grapheme ...
```

### Step 2: Try out Festival
Now you can try Festival with built-in voices like this:

```
cd build/festival 
./bin/festival
```

You will now be presented with the Festival prompt. From here you can type commands to produce synthetic speech using the built-in TTS voice. Here are some commands you should try. (**Just type what you see after `festival>`.** )

```
festival> (SayText "Hello world.")
festival> (set! utt1 (SayText "Hello world.")) 
festival> (utt.save.wave utt1 "example.wav") 
festival> (exit)
```

### Step 3: Build your own TTS voice
1. Make sure you are in the `build` directory. Then type these commands. Make sure there are no errors after the two `ls` statements and that they just list the contents of the `speech_tools` and `festvox` directories, respectively.

```
cd ..   # this will back you up from build/festival to buils
pwd     # confirm that you are in the build directory
export ESTDIR="`pwd`/speech_tools"
export FESTVOXDIR="`pwd`/festvox"
ls $ESTDIR
ls $FESTVOXDIR
```

2. Create a directory where your voice data will live. **Replace `ep` with your own initials!**

```
mkdir bc_us_ep
cd bc_us_ep
$FESTVOXDIR/src/clustergen/setup_cg bc us sp
```

## Activity 2: Modifying prosody with Praat and Python


