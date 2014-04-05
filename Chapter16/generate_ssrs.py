# Generate 1024 samples for Square, Saw, Triangle and Sine
# Amplitude = 100
import math

print "memory_initialization_radix=10;"
print " memory_initialization_vector="


# Square
for i in range(1024):
    if i < 512: print 128 + 100,","
    else:       print 128 - 100,","

# Saw
for i in range(1024):
    print 128 - 100 + (i * 200) / 1024,","

# Triangle
for i in range(1024):
    if i < 512: print 128 - 100 + (i * 200) / 512,","
    else:       print 128 + 100 - ((i-512) * 200) / 512,","


# Sine
for i in range(1024):
    print int(math.sin(i*math.pi / 512) * 100) + 128,","
