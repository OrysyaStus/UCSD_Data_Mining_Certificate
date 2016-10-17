# ### Python for Informatics ###
# Assignment 3
# "Looping, Searching, and Slicing"
# 
# ## Orysya Stus ##
# 10.3.2016

avg_string = 'Average value read: 0.72903'
begin = avg_string.find(':')
number = float(avg_string[begin+2: ])
print 'The floating number is', number