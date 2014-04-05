import math

print "memory_initialization_radix=10;"
print " memory_initialization_vector="


f = open("/tmp/sample16.raw", "rb")

s = f.read()

i = 0
while i < len(s):
    h = ord(s[i])
    i += 1
    l = ord(s[i])
    i += 1

    v = h + l*256

    if (v & 0x8000): v -= 0x8000
    else: v += 0x8000

    print v,","


f.close()
