# Extracting Data from XML
# Orysya Stus

import urllib
import xml.etree.ElementTree as ET

serviceurl = 'http://pr4e.dr-chuck.com/tsugi/mod/python-data/data/comments_174248.xml'
count = 0
sum = 0

while True:
	address = raw_input('Enter location: ')
	if len(address) < 1 : break

	url = serviceurl + urllib.urlencode({'sensor':'false', 'address': address})
	print 'Retrieving', url
	uh = urllib.urlopen(url)
	data = uh.read()
	print 'Retrieved',len(data),'characters'
	#print data
	tree = ET.fromstring(data)
	bam = tree.findall('comments/comment')
	for item in bam:
		counts = item.find('count').text
		sum = sum + int(counts)
		count = count + 1
	print 'Count: ', count
	print 'Sum: ', sum

# data = '''<commentinfo>
#		<comments>
#			<comment>
#				<name>Romina</name>
#				<count>97</count>
#			</comment>
#		</comments>
#	</commentinfo>'''