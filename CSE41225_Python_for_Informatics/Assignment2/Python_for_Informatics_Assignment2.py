# ### Python for Informatics ###
# Assignment 2
# "Functions"
# 
# ## Orysya Stus ##
# 10.3.2016

def to_number(string):
    integer = int(string)
    return integer

def add_two(n1, n2):
    sum_int = n1 + n2
    return sum_int

def cube(n):
    cubed = n*n*n
    return cubed

n1 = raw_input("Enter first number: ")
n2 = raw_input("Enter second number: ")
combination_function = cube(add_two((to_number(n1)), (to_number(n2))))
combination_function