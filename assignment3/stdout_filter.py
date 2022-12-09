input = open("logs.txt", 'r')
output = open("A3_227545.txt", 'w')
for line in input:
    if 'Step' in line:
        output.write(line)
input.close()
output.close()