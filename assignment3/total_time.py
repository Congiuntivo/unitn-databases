input = open("A3_227545.txt")
total_time = 0
for line in input:
    total_time += int(line.split()[3])
minutes = total_time // (60 * 1000 * 1000)
seconds = total_time % (60 * 1000 * 1000) * 0.01 * 60
seconds = int(str(seconds)[0:2])
print("Total time: %d:%d" % (minutes, seconds))
input.close()