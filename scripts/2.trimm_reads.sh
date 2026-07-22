#!/bin/bash
# Remove adapters (ILLUMINACLIP:TruSeq3-PE.fa:2:30:10)
# Drop reads below the 142 bases long (MINLEN:142)
# No quality trimming as this effects downstream results
# and the data is phred >30

##### mamba activate stack-v2.64 #####

#DATA=/home/wheeled/projects/202407mcoleman/
adapt_path=/home/wheeled/mambaforge/envs/stack-v2.64/share/trimmomatic-0.39-2/adapters

for r1 in "$1"/*_1.fastq.gz
do
	r2="${r1%_1.fastq.gz}_2.fastq.gz"
	r1_out="${r1%_1.fastq.gz}.adtrim.1.fq.gz"
	r1_out_unpaired="${r1%_1.fastq.gz}.unpaired.1.fq.gz"
	r2_out="${r2%_2.fastq.gz}.adtrim.2.fq.gz"
	r2_out_unpaired="${r2%_2.fastq.gz}.unpaired.2.fq.gz"
	log="${r1%_1.fastq.gz}.log.txt"
	summary="${r1%_1.fastq.gz}.summary.txt"

	echo "$r1"
	echo "$r2"
	echo "$r1_out"
	echo "$r2_out"
	trimmomatic PE -threads 50 -trimlog "$log" -summary "$summary" \
	       	"$r1" "$r2" "$r1_out" "$r1_out_unpaired" "$r2_out" \
			"$r2_out_unpaired" ILLUMINACLIP:"$adapt_path"/TruSeq3-PE-2.fa:2:30:10 \
			MINLEN:142
done
