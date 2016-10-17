# ### Python for Informatics ###
# Assignment 3
# "Looping, Searching, and Slicing"
# 
# ## Orysya Stus ##
# 10.3.2016

num = raw_input("Enter number: ")
total = 0
count = 0
list_num = []
average = 0
while num != 'done':
    num = int(num)
    total = total + num
    count = count + 1
    list_num.append(num)
    maximum = max(list_num)
    minimum = min(list_num)
    average = total/count
    print 'The total is:', total
    print 'The count is:', count
    print 'The maximum is:', maximum
    print 'The minimum is:', minimum
    print 'The average is:', average
    num = raw_input("Enter number: ")