NANO_TO_SEC = 1000 * 1000 * 1000
input = open("A3_227545.txt")
total_time = 0
for line in input:
    total_time += int(line.split()[3])
minutes = total_time // (60 * NANO_TO_SEC)
seconds = (total_time // NANO_TO_SEC) % 60
print("Total time: %d:%d" % (minutes, seconds))
input.close()