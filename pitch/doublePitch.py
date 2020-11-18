import sys

f = open(sys.argv[1])
g = open("new-" + sys.argv[1], "w")
for line in f:
    line = line.rstrip()
    if "\t" in line:
        parts = line.split()
        
        # first bit is time stamp, second is pitch
        # let's double the pitch

        newpitch = float(parts[1]) * 2
        g.write(str(parts[0]) + "\t" + str(newpitch) + "\n")
#        print(parts[0], "\t", newpitch)
    else:
        g.write(line + "\n")

f.close()
g.close()
