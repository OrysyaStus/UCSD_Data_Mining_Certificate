# ### Python for Informatics ###
# Assignment 4
# "Files, Lists, and Split"
# 
# ## Orysya Stus ##
# 10.4.2016

def freq_count(string, list_things):
    count = 0
    for thing in list_things:
        A = [m.start() for m in re.finditer(string, thing)]
        for i in A:
            if i >= 0:
                count = count + 1
            else:
                count = count
    print 'The string', string, 'occurs', count, 'times'
	
#local_directory = 'C:\Users\Orysya\Desktop\Python_for_Informatics\Assignment4\romeo.txt'
file_name = raw_input("Enter a filename: ")
string = raw_input("Enter a string of interest: ")
handle = open(file_name)
script_list = list()

for line_list in handle:
    line_list = line_list.rstrip()
    line_list = line_list.split()
    for i in line_list:
        if i in script_list:
            continue
        else:
            script_list.append(i)
script_list.sort()
print script_list

freq_count(string, script_list)