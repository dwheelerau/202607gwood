#!/bin/bash

#################################################
### NOT USED HERE AS I DID THE DEMULTIPLEXING ###
#################################################


# add /1 /2 to fastq headers
for R1 in data1/*1.fq.gz
do 
	R2=$(echo $R1 | sed 's/.1.fq.gz/.2.fq.gz/g')
	out1=$(echo $R1 | sed 's/1.fq.gz/slash.1.fq.gz/g')
	out2=$(echo $R1 | sed 's/1.fq.gz/slash.2.fq.gz/g')
	echo $R1
	echo $R2
	echo $out1
	echo $out2
	reformat.sh in1=$R1 in2=$R2 out1=$out1 \
		out2=$out2 addslash=t slashspace=f
done
