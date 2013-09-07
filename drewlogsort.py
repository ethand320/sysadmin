


file = open('drewlog.txt', "r")
blockList = []

while True:
    line1 = file.readline()
    line2 = file.readline()
    line3 = file.readline()
    line4 = file.readline()
    string = line1 + line2 + line3

    #block = [line1, line2, line3]

    blockList.append(string)
    
    
    if not line4: break  #eof conditional
    

blockList.sort()
    #print(blockList)
file.close()
for line in blockList:
    file2 = open('sorted.out', 'a')
    file2.write(line)
    file2.write('\n')
    
    print(line)
file2.close()

