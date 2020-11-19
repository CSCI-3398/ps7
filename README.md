# Problem Set 7: Prosody modification for TTS
In this (very easy!) problem set, you will writing a script to turn a statement into a question by modifying the pitch (F0). In the `pitch` directory of this repo, I've given you some scripts to get you started (a Python script, two Praat scripts, and a bash script), as well as a `.wav` to experiment with.

*NOTE: The  `ttsvoice` directory contains an optional extra credit assignment. There is a `README` in that directory that will tell anyone who is interested what to do. I will not be able provide technical support for the extra credit assignment.* 


### Step 1
Open Praat, then open the `getPitchTier.Praat` Praat script. You should be able to run it without making any modifications. (Make sure you're not muting the sound on your computer so you can hear it!)

### Step 2
In the `pitch` drectory, you'll now see a new file called `inputPitchTier.PitchTier`. Call `cat` or `head` on the file, or open it with a good text editor (not Microsoft Word), and you'll see that it has a few lines of obligatory metadata followed by pitch information in this format, where the two fields are separated by tabs:

```
timestamp1    pitchvalue1 
timestamp2    pitchvalue2
```

### Step 3
Run the Python program `doublePitch.py` on that file to double the pitch values. This program will create a new `PitchTier` called `new-inputPitchTier.PitchTier`. It will take as an argument the `PitchTier` created in Step 2, above. This is how you would do this from a  command line (keeping in mind that you might be able to type `python` instead of `python3` depending on how you have Python installed).

```
python3 doublePitch.py inputPitchTier.PitchTier
```

### Step 4 
Now you can resynthesize the original `.wav` file with a new pitch track that is twice as high as the original pitch track using the `replacePitchTier.Praat` script. Open Praat, open the script in Praat, and then run.

### Step 5 (optional)
Have a look at the file `runPraatScript.sh`. This shows you how to run the code in steps 1-4 from a terminal without actually opening Praat! (Adjust the commands for your operating system as indicated in the comments. You will have to know the full path to Praat on your computer.)

```
chmod +x runPraatScript.sh 
./runPraatScript.sh
```

### Step 6
Your task is to replace the `doublePitch.py` program with a Python program that turns a "statement intonation" `PitchTier` into a "question intonation" `PitchTier` for any sentence contained in a `.wav` file. It should take the same input as `doublePitch.py` and it should produce a new `PitchTier` file, just as `doublePitch.py` produced. 

Here are some ideas to help you get started.

* Take the last, e.g., 20% of your input `PitchTier` and make the pitch go up instead of down by replacing the pitch values with some increasing value above the mean overall pitch.

* Record yourself saying a sentence with question intonation. Extract that pitch tier and then add or subtract values from the beginning or end until it’s the same length as the `PitchTier` you are trying to modify. Then use that as your new `PitchTier`.

* Do as above, but use piecewise linear interpolation between time points. There are a various linear interpolation functions in numpy, scipy, pandas. An easy one to use is `numpy.linspace`, which gives you a series of evenly spaced numbers between two numbers.
 
### DELIVERABLES 
*  Add, commit, and push your Python program called `statement2question.py`. You are also free to update the Praat scripts, but I must be able to run them exactly as I do in `runPraatScript.sh`. I do not want to have to open any files to be able to hear the original audio, run all the scripts, and then hear the new audio.

* Add, commit, and push a pdf describing the strategy you used and what fancier things you could have done if you had more time.

