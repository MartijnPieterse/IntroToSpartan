import math

print "memory_initialization_radix=10;"
print " memory_initialization_vector="


for i in range(1024):
    print int(math.sin(i*math.pi / 512) * 100) + 128,","
