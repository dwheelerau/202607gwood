#!/bin/bash
src=/home/wheeled/projects/202607gwood 

#### popfile needs updating ####
POPMAP=$src/pop-final.txt

DATA=$src/data/adtrim.stdlen

files="BAT10-1B
BAT11-1A
BAT13-2E
BAT19-1C
BAT20-1D
BAT22-2H
BAT23-1C
BAT25-2E
BAT3-2H
BAT41-2F
BAT4-1A
BAT46-1A
BAT46-2G
BAT47-2G
BAT48-2F
BAT49-2G
BAT50-1B
BAT5-1A
BAT8-2H
BAT9-1D
BBCS01-1E
BBCS01-1F
BBCS02-1E
BBCS03-2E
BBCS04-1C
BBCS05-2H
BBCS06-2H
BBCS07-2H
BBCS08-1A
BBCS09-1B
BBCS10-1C
BBCS11-1C
BBCS12-1B
BBCS13-1D
BBCS14-1A
BBCS15-1B
BERM01-1B
BERM02-1F
BERM03-2F
BERM04-1C
BERM05-2H
BERM06-1D
BERM07-1C
BERM08-2F
BERM09-1A
BERM10-1D
BERM13-1B
BERM14-1A
BERM15-2G
BERM16-2E
Blank1-1H
Blank-1H
DIS01-1B
DIS01-1E
DIS02-2H
DIS03-1G
DIS04-1H
DIS05-1H
DIS06-2F
DIS07-1B
DIS08-2E
DIS09-1C
DIS10-1D
DIS10-1E
DIS11-1F
DIS12-1E
DIS12-2G
DIS13-2H
DIS14-2E
DIS15-1D
DIS16-1B
EDDA01-1E
EDDA02-1A
EDDA02-1A2
EDDA03-1H
EDDA04-2E
EDDA05-1D
EDDA06-2G
EDDA07-1B
EDDA08-1A
EDDA09-2H
EDDA10-1B
EDDA11-1A
EDDA12-1C
EDDA13-1C
EDDA14-1B
EDDA15-2H
EDE12-2G
EDE20-1C
EDE21-1D
EDE22-2E
EDE23-1C
EDE24-1B
EDE25-1D
EDE27-1C
EDE33-2F
EDE34-2H
EDE35-1D
EDE36-1A
EDE37-1D
EDE39-1D
EDE42-1A
EDE4-2E
EDE44-1B
EDE45-2G
EDE46-1C
EDE49-2E
EDE50-2E
EDE5-1B
EDQ01-1G
EDQ02-1F
EDQ02-1H
EDQ03-2H
EDQ04-1B
EDQ05-2F
EDQ06-1B
EDQ08-1D
EDQ09-2F
EDQ10-2E
EDQ11-1D
EDQ12-2G
EDQ13-1A
EDQ14-1A
EDQ15-1A
EDQ18-2G
GC01-1G
GC02-1E
GC03-1D
GC04-2F
GC05-1C
GC06-1C
GC07-1A
GC08-2F
GC09-1D
GC10-2G
GC11-1B
GC12-2G
GC13-2H
GC14-1B
GC15-1B
MER01-1H
MER02-1G
MER03-2E
MER04-1A
MER04-2G
MER05-1C
MER06-2H
MER07-1H
MER08-1G
MER09-1E
MER09-2E
MER10-1A
MER11-1D
MER12-1D
MER13-1D
MER14-1E
MER15-2F
NR01-1A
NR02-1G
NR02-2F
NR03-1E
NR04-2G
NR06-1H
NR07-1H
NR08-1G
NR09-1C
NR10-1A
NR11-2G
NR12-2F
NR13-2G
NR14-2E
NR15-1D
NR16-2G
FB1-1B
FB3-1B
FB4-1B
FB6-1B
FB8-1B
ABC9-1B
ABC10-1B
ABC11-1B
ABC13-1B
ABC14-1B
ABC16-1B
ABC17-1B
ABC18-1B
ABC19-1B
ABC21-1B
ABC24-1B
ABC23-1B
QB24-1B
QB25-1B
QB26-1B
QB27-1B
QB28-1B
QB29-1B
QB30-1B
QB31-1B
QB32-1B
QB33-1B
QB35-1B
QB36-1B
QB37-1B
QB34-1B
QB38-1B
QB39-1B
QB40-1B
QB41-1B
QB42-1B
QB43-1B
QB44-1B
QB45-1B
QB46-1B
QB47-1B
QB48-1B
DM49-1B
DM50-1B
DM51-1B
DM52-1B
DM53-1B
DM54-1B
DM55-1C
DM56-1C
DM57-1C
DM58-1C
MB59-1C
MB60-1C
MB61-1C
MB62-1C
MB63-1C
MB64-1C
MB65-1C
MB66-1C
MB67-1C
MB68-1C
MB69-1C
MB70-1C
MB72-1C
MB73-1C
BB74-1C
BB75-1C
BB76-1C
BB77-1C
BB78-1C
BB79-1C
BB80-1C
BB81-1C
BB82-1C
BB83-1C
BB84-1C
BB85-1C
BB86-1C
BB87-1C
BB88-1C
MM89-1C
MM90-1C
MM91-1C
MM92-1C
MM93-1C
NS101-1C
NS102-1C
NS103-1C
NS104-1C
NS105-1C
NS106-1C
NS107-1C
NS108-1C
NS110-1C"

# Build loci de novo in each sample for the single-end reads only. If paired-end reads are available, 
# they will be integrated in a later stage (tsv2bam stage).
# This loop will run ustacks on each sample, e.g.
#   ustacks -f ./samples/sample_01.1.fq.gz -o ./stacks -i 1 --name sample_01 -M 4 -p 8
#
### H125C1-1B_ACTCGCA.adtrim.stdlen.1.fq.gz ###
mkdir -p $src/stacks

echo "Stacks started at"
date

echo "Processing the following samples"
echo $files

id=1
for sample in $files
do
    #### set m, M, N ####
    echo "running $sample with ustacks"
    ustacks -m 3 -M 3 -N 5 -t gzfastq -f $DATA/${sample}_*.1.fq.gz \
	    -o $src/stacks -i $id --name $sample -p 64
    let "id+=1"
done

# 
# Build the catalog of loci available in the metapopulation from the samples contained
# in the population map. To build the catalog from a subset of individuals, supply
# a separate population map only containing those samples.

#### set n ####
echo "Running cstacks"
date

cstacks -n 3 -P $src/stacks/ -M $POPMAP -p 100

#
# Run sstacks. Match all samples supplied in the population map against the catalog.
#
echo "Running sstacks"
date

sstacks -P $src/stacks/ -M $POPMAP -p 100

#
# Run tsv2bam to transpose the data so it is stored by locus, instead of by sample. We will include
# paired-end reads using tsv2bam. tsv2bam expects the paired read files to be in the samples
# directory and they should be named consistently with the single-end reads,
# e.g. sample_01.1.fq.gz and sample_01.2.fq.gz, which is how process_radtags will output them.
# CHANGE READS DIR
echo "running tsv2bam"
date

tsv2bam -P $src/stacks/ -M $POPMAP --pe-reads-dir $DATA -t 100

#
# Run gstacks: build a paired-end contig from the metapopulation data (if paired-reads provided),
# align reads per sample, call variant sites in the population, genotypes in each individual.
##
echo "running gstacks"
date

# careful RAM issues, ddRAD protocol dont remove duplicates! 
gstacks -P $src/stacks/ -M $POPMAP -t 32 

#
# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics
# export several output files.

# batchsize default is 10000
#### CHANGE FASTA FILE OUTPUTS #####
echo "Running populations"
date

populations -P $src/stacks/ -M $POPMAP --vcf \
	--genepop --structure --fstats --hwe --fasta-loci \
	--fasta-samples -t 32 --batch-size 50000
