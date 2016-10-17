# ### Python for Informatics ###
# Assignment 6
# "URL Reader"
# 
# ## Orysya Stus ##
# 10.4.2016

# URL: https://www.linkedin.com/

import urllib
import re

try: 
    url = raw_input('Enter a URL to read from: ')
    fhand = urllib.urlopen(url)
    count = 0;
    new_3000 = []
    while count < 3000:
        new_char = fhand.read(1)
        new_3000 = new_3000 + re.findall('[A-Za-z]', new_char) # only characters upper and lowercase a-z.
        count += 1
    print 'The first 3000 characters are: ', new_3000
    
    new_chars = fhand.read()
    entire_doc = new_3000 + re.findall('[A-Za-z]', new_chars)
    print 'The length of the entire document is: ', len(entire_doc)    
except: 
    print "Improperly formatted or non-existent URL"