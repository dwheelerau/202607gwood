# 202607gwood  

## Introduction  
Stacks analysis of RADseq data for **E. radiata**. Combine data from
George and Reina. Run denovo-stacks for population genomics. Also, run
reference stacks for comparison and as an excuse to write the scripts.      

## Issues!  
Next time rename the files so they are in the correct format from the start of the pipeline and also
check that the proper PE naming notation is used for the fastq headers (see below).  
- using the filenames with barcodes does not work as tsv2bam requres the format <sample>.1.fq.gz
- the fastq headers are missing /1 /2 tags so tsv2bam fails, use `fix_fastq_headers.sh` to fix this
- The blank seems to contain orphin pairs, removing them from the analysis allows the pipeline to complete
- EDDA02-1A and EDDA02-1A2 both get globbed when using `ustacks -m 3 -M 3 -N 5 -t gzfastq -f $DATA/${sample}*.1.fq.gz`

The last error above causes the pipeline to crash because two files are passed to ustacks as input for EDDA02-1A,
the other sample is processed correctly as EDDA02-1A2 will not pickup the other sample in the wild card search. To
fix this I rand EDDA02-1A manually outside of the loop assigning 71 as the ID, which is the number that would have
been assigned had it worked.  

## Workflow  
1. Fastqc and multiqc summary.  
Nothing jumps out. The minimum R1 read is 142 bases, so will hard trim
to this to avoid length bias, this is really not required, but would be
consistent with our other work. The R2 is 150bp, will leave that as the
QC shows phred scores >30 across the length of the read so I can let the
Quality algorithms just do their job rather than using trimming.      

I used `multiqc` to generate a summary report of all the many fastqc reports.  

**I should have used `0.5.add_slash.sh` to add the \1 and \2 tags to the fastq headers**

2. Trim adaptors using trimomatic     
Fastqc does show adaptors need to remove these. We do not apply any
quality trimming as the reads are high quality, so w can let the downstream
algorithms parse quality scores in a more sensible way.  

3. Hard trim the R1 using bbduk    
The R1 read is variable in length depending on the length of the barcode
sequence that was removed during pre-processing. In theory there could
be a bias introduced because of these length differences, although
this is likely to be very minor given it is only a few nucleotides. 
However, to be consistent with previous analyses we can hard trim all
these R1 reads to the same length of 142bp. This is controlled by the 
following bbduk parameter `forcetrimright=141` (uses 0 based indexing).  

Finally the outputs are group into a new directory `data/adtrim.stdlen/`.  

**At this point I should have removed the barcodes from the filenames so they were <sample.1.fq.gz> etc**

4. Re-run fastqc just to check that nothing silly has happend during processing  
7. Stacks *de novo*  
As indicated above I had a few issues with the \1 \2 fastq headers, the filenames,
the blanks samples containing orphin pairs, and the EDDA02 wildcard clash. To overcome these
issues I have a several `7.stacks` scripts.  

The data is located in `data/adtrim.stdlen/` (inc blank, \1 \2) and `data/adtrim.stdlen2/` (no blank)

`scripts/7.stacks.sh` - first run failed when server crashed, uses all samples for catalogue
`scripts/7.stacks-ref.sh` - testing reference based calling
`scripts/7.stacks-restart.sh` - restart uses `$DATA/${sample}_*.1.fq.gz` so no wildcard clash, but fails at blank. See `logs/stacks.run2-restart.log`   
`scripts/7.stacks-subset.sh` - Uses top 5 coverage samples per pop to reduce processing time, crashed at blank.  
`scripts/7.stacks-subset2.sh` - As above, but re-start after EDDA02 wildcard issue.  

This script runs through the stacks workflow, the steps are as follows:  

## Build de novo loci using ustacks with the forward read only  
This step assembles stacks loci based on the forward read only,
the second pair will be incorporated at later steps ie `tsv2bam`.
A loop is used to run ustacks on each sample, with an id tag
starting with 1 that increases by one each iteration.   

## Build a catalog describing the metapolulation of loci    
In this project all samples are used, but when there are a large
number of individuals it may be better to use a subset of representative
individuals from each population. This could be something like the 5 
highest coverage individuals from each. This has two effects, first it reduces
run-time and RAM requirements, second it reduces the number of rare
alleles that provide no information on broader population dynamics. Note
in later steps all samples are compared to this catalog.   

## Group sample loci by locus sequence  
This `tsv2bam` step incorporates the second read pair.  

## Build paired-end contigs and align reads for variant calling  
Variants are called and individuals are genotyped with `gstacks`.    

## Run populations  
A range of population level statics and file exports for downstream
applications.   

9. Reference based stacks for testing   
- Align each sample with BWA to the reference genome.  
- run `ref_map.pl`  

## Run gstacks to remove PCR duplicates  
See `9.stacks-ref.sh`.  

## Run populations  
As before.  
