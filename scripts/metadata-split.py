#!/usr/bin/env python

import csv

filename = '16951-1A_22KV2FLT3_AGTTCC_L007_R1'
filename_h = open(filename + '_barcodes.txt', 'w')

with open('metadatav3_long.csv') as rf:
	csv_reader = csv.reader(rf)
	for row in csv_reader:
		file = row[0].strip()
		if file != filename:
			filename = file
			filename_h = open(filename + '_barcodes.txt', 'w')
		barcode = row[1]
		sample = row[2]
		out = '%s\t%s\n' % (barcode, sample)
		filename_h.write(out)
