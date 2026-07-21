#!/usr/bin/env python
from Bio import SeqIO
import sys

# parse vcf file and extract target stacks

# vcf
vcf = sys.argv[1]
fasta = sys.argv[2]

vcf_dict = {}
with open(vcf) as rf:
	for line in rf:
		if line[0] != '#':
			bits = line.strip().split('\t')
			loci, pos, ids, ref, alt = bits[:5]
			loci = "CLocus_%s" % loci
			vcf_dict[loci] = "%s %s %s %s" % (pos, ids, ref, alt)

outfile = open('outfile.fa', 'w')
with open(fasta) as rf:
	for rec in SeqIO.parse(rf, 'fasta'):
		if rec.id in vcf_dict:
			rec.description = vcf_dict[rec.id]
			SeqIO.write(rec, outfile, 'fasta')
outfile.close()

	


