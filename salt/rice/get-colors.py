#!/usr/bin/env python3
import argparse
import os.path
import sys

import pywal

# {{{1 Configure arg parser
parser = argparse.ArgumentParser(description='Get primary colors in image')
parser.add_argument('image', help='Image from which to retrieve colors')

args = parser.parse_args()

# {{{1 Check if image exists
if not os.path.isfile(args.image):
    print("{} not a file".format(args.image))
    sys.exit(1)

# {{{1 Get colors
colors = pywal.colors.get(args.image)

max_len = 0
for parent_key in ['special', 'colors']:
    for key in colors[parent_key]:
        if len(key) > max_len:
            max_len = len(key)
        
print_str = '{:<'
print_str += str(max_len)
print_str += '}: {}'

for parent_key in ['special', 'colors']:
    for key in colors[parent_key]:
        print(print_str.format(key.capitalize(), colors[parent_key][key]))
