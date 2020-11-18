#!/bin/sh

# ON A MAC
echo "Extracting a pitch tier"
/Applications/Praat.app/Contents/MacOS/Praat --run getPitchTier.Praat 

# FOR LINUX, something like this, depending on where Praat is installed
# /usr/bin/praat --run getPitchTier.Praat

# Using the command line on Windows, something like this, again depending on where Praat is installed
# "C:\Program Files\Praat.exe" --run getPitchTier.Praat

# more info here: http://www.fon.hum.uva.nl/praat/manual/Scripting_6_9__Calling_from_the_command_line.html

echo "Modifying the pitch tier..."
python3 doublePitch.py inputPitchTier.PitchTier

echo "Resynthesizing with that pitch tier"
/Applications/Praat.app/Contents/MacOS/Praat --run replacePitchTier.Praat 
