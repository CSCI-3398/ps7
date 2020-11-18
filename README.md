# Problem Set 7: TTS
For this problem set, you will **choose _*one*_ of the following two activities**.

1. Build a parametric TTS system using your own voice. This involves less programming but lots of unix and following directions very carefully. If you are a Windows user, I recommend not trying this option since I won't be able to provide technical support.

2. Write a program to turn the prosody of a statement into the prosody of a question. This involves more programming and not much unix or following directions.  

The deliverables for the two activities are described below. You will submit add, commit, and push the deliverables by the deadline, Tuesday, November 24, at 11:59pm.

## Activity 1: Building a TTS system with your own voice
This will be complicated, but you won't need to do any actual programming. If you are good with unix, you will be able to finish this in less than an hour. If you are not good with issuing unix commands, I recommend Activity #2.

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

### Step 3: Make your recordings
1. Make sure you are in the `build` directory. Then type these commands. Make sure there are no errors after the two `ls` statements and that they just list the contents of the `speech_tools` and `festvox` directories, respectively.

```
cd ..   # this will back you up from build/festival to build
pwd     # confirm that you are in the build directory
export ESTDIR="`pwd`/speech_tools"
export FESTVOXDIR="`pwd`/festvox"
ls $ESTDIR
ls $FESTVOXDIR
```

2. While still in the `build` directory, create a new directory where your voice data will live. **Replace `ep` with your own initials!**

```
mkdir bc_us_ep
cd bc_us_ep
$FESTVOXDIR/src/clustergen/setup_cg bc us sp
mv ../../txt.done.data etc/
```

3. Now you should be in your own voice directory (in my case, the `bc_us_ep` directory). Open the file in the `bin` directory called `prompt_them`. Find the line that says `#USE_SOX=1` and remove the `#` so that it is uncommented, then save the file. 

4. Still in your own voice directory type this to create the prompts:

```
./bin/do_build build_prompts
```

5. Now you will record the prompts. When you issue the command below, it will prompt you to record one sentence at a time. It should generate recordings in the `wav/` directory. The `prompt_them` script can be stopped with `ctrl-c` and restarted at the line number given as the second argument.

```
./bin/prompt_them etc/txt.done.data 1
```

6. When you have recorded all 100 sentences, you might need to power normalize and resample your recordings. 

```
mv wav/*wav recording 
./bin/get_wavs recording/*.wav
```

### Step 4: Build your voice
While still in your own voice directory (for me `bc_us_ep`), try running the following. It will produce a lot of output and will take a while (10-20 minutes) to run.


```
./bin/build_cg_voice
```

If you get an error immediately, it's probably because you're not in the right directory or you put some files in the wrote place so review the instructions above to make sure everything is where it should be. Particularly make sure that you have your power-normalized recordings in the `wav/` folder and the list of sentences in the `etc/txt.done.data` file. If you get errors further down the line, they might be difficult to resolve, but give it a try. 

### Step 5: Test your voice
Once you've built your voice, check to see whether the Mel Cepstral Distortion of your voice is within normal range. The value for MCD mean should be between 3 and 8.

```
$FESTVOXDIR/src/clustergen/cg_test resynth cgp >mcd-base.out 
cat mcd-base.out
```
Next, run Festival using your voice! Don't forget to replace the path below with *your* path to festival and to replace `ep` with *your* initials and to provide the full path to your festival directory (and, of course, don't type festival> when you're running festival). Stay in your voice directory and type:

```
/Users/emilypx/Desktop/ps7/ttsvoice/build/festival/bin/festival festvox/cmu_us_ss_cg.scm 
festival> (voice_bc_us_ep_cg)
festival> (SayText "Behold the sound of my voice")
```
### DELIVERABLES
* Submit `.wav` files for three sentences synthesized with your voice that sound okay. 

* Submit `.wav` files for three sentences synthesized with your voice that contain really bad mistakes. 

* Submit a pdf describing your opinions about these sentences. What are the good qualities of the good sentences? What are the bad qualities of the bad sentences?


## Activity 2: Modifying prosody with Praat and Python
In the `pitch` directory of this repo, there is a `.wav` file, a Python script, and two Praat scripts.

### Step 1
Open Praat, then open the getPitchTier.Praat script. Change the paths to make them point at your `pitch` directory and the `sentence.wav` file included in the directory, and then run it. (Make sure you're not muting the sound on your computer so you can hear it.)

### Step 2
In the `pitch` drectory, you'll now see a new file called `oldPitchTier.PitchTier`. Open it with a good text editor (not Microsoft Word), and you'll see that it has a few lines of obligatory metadata followed by pitch information in this format, where the two fields are separated by tabs:
```
timestamp1 pitchvalue1 timestamp2 pitchvalue2
```
### Step 3
Run the script `doublePitch.py` on that file to double the pitch values, and save it out to a new file called `newPitchTier.PitchTier` like this:
```
python3 doublePitch.py oldPitchTier.PitchTier > newPitchTier.PitchTier
```

###4. Now you can resynthesize the original wav file with the new pitch track that is twice as high as the original pitch track using the replacePitchTier.Praat script. Open it in Praat, change the paths to point at your files, and then run. (Again, make sure mute is off!)
5. Have a look at the file runPraatScript.sh, also in this directory. This shows you how to do steps 1-4 without actually opening Praat. (Adjust the commands for your operating system as indicated in the comments.)
chmod +x runPraatScript.sh ./runPraatScript.sh
Your task is to write a python script that turns statement intonation PitchTier into a question intonation PitchTier for any sentence contained in a .wav file.
Here are some ideas to help you get started.
Idea 1: Take the last, e.g., 20% of your input PitchTier and make the pitch go up instead of down by replacing the pitch values with some increasing value above the mean overall pitch.
Idea 2: Record yourself saying a sentence with question intonation. Extract that pitch tier and then add or subtract values from the beginning or end until it’s the same length as the PitchTier you are trying to modify. Then use that as your new PitchTier.
Idea 3: Do as above, but use piecewise linear interpolation between time points. There are a various linear interpolation functions in numpy, scipy, pandas. An easy one to use is numpy.linspace, which gives you a series of evenly spaced numbers between two numbers.
 
Q11. What strategy did you use, and how did you arrive at that strategy? What would you have done if you had had more time?
Q12. Submit your script, statement2question.py, in the Dropbox. The script should take a PitchTier file as input and it should output a PitchTier file of the same length but with different pitch values. Points will be taken off for scripts that cannot be run exactly as the one I've provided for double pitch.

