# ### Python for Informatics ###
# Assignment 5
# "Message Frequency Count"
# 
# ## Orysya Stus ##
# 10.4.2016

#local_directory = 'C:\Users\Orysya\Desktop\Python_for_Informatics\Assignment5\mbox.txt'
file = raw_input('Please enter file name: ')
handle = open(file)
data1 = list()
data2 = dict()
for line in handle:
    line = line.rstrip()
    if not line.startswith('From'):
        continue
    line = line.split()
    line = line[1]
    data1.append(line)
for i in data1:
    data2[i] = data2.get(i,0)+1

word = None
max = None

for aa, bb in data2.items():
    if max is None or bb > max:
        word = aa
        max = bb

print word, max