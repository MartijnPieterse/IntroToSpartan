import math

print "memory_initialization_radix=10;"
print " memory_initialization_vector="


f = open("/tmp/sample.raw", "rb")

for c in f.read():
    print ord(c), ","

f.close()
