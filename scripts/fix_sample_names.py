#!/usr/env python  

from pathlib import Path  

path = Path("data/adtrim.stdlen")

fastq_files = list(path.glob("*1.fq.gz"))
samples = []
sample_groups = {}
with open('pop-final.txt.old') as rf:
	for line in rf:
		sample = line.split('\t')[0]
		pop = line.split('\t')[1].strip()
		samples.append(sample)
		sample_groups[sample] = pop

sample_dict = {}
for s in samples:
	for f in fastq_files:
		f = str(f).split('/')[-1].split('_')[0]
		if f.find(s)>-1:
			if s in sample_dict:
				sample_dict[s].append(f)
			else:
				sample_dict[s] = [f]
outfile = open('pop-final.txt', 'w')
for s in sample_dict:
	outfile.write(f'{sample_dict[s][0]}\t{sample_groups[s]}\n')
outfile.close()
