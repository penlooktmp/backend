#!/usr/bin/env python
import sys
import re
import os

root  = os.getcwd()
files = [sys.argv[1]]

def parse(index):
	target = root + '/' + files[index]
	with open(target, "r") as zepfile:
		for line in zepfile:
			if line.strip().startswith('use'):
				class_name = line.strip().split(' ')[1].split(';')[0]
				class_path = class_name.lower().replace('\\', '/')
				file_path  = class_path + '.zep'

				if os.path.isfile(file_path):
					if not file_path in files:
						files.append(file_path)
				else:
					for file in files:
						print file
					print "Target file: " + target
					raise Exception("File not found " + file_path)
			else:
				if line.strip().startswith('{'):
					break

	if len(files) > index + 1:
		parse(index + 1)

parse(0)

print "TOTAL ", files.__len__()
#for file in files:
#	print file
#exit(0)

from os import *

system('zephir fullclean')
system('rm -rf ./build')
system('mkdir build')

for file in files:
	dest = root + '/build/' + file
	last_splash = dest.rindex('/')
	folder = dest[:last_splash]
	system('mkdir -p ' + folder)
	cmd = 'cp -rf ' + root + '/' + file + ' ' + dest
	system(cmd)

system('cp -rf ./ext ./build/ext')
system('cp -rf ./phpc ./build/phpc')
system('cp -rf ./config.json ./build/config.json')
system('cd build && zephir builddev')
