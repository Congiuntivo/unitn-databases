input = open("A3_227545.txt")
total_time = 0
for line in input:
    total_time += int(line.split()[3])
minutes = total_time // (60 * 1000 * 1000)
seconds = (total_time // (1000 * 1000)) % 60
print("Total time: %d" % total_time)
print("Total time: %d:%d" % (minutes, seconds))
input.close()