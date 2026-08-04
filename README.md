# 202607gwood  

## Introduction  
Stacks analysis of RADseq data for **E. radiata**. Combine data from
George and Reina. Run denovo-stacks for population genomics. Also, run
reference stacks for comparison and as an excuse to write the scripts.      

## Workflow  
1. Fastqc and multiqc summary.  
Nothing jumps out. The minimum R1 read is 142 bases, so will hard trim
to this to avoid length bias, this is really not required, but would be
consistent with our other work. The R2 is 150bp, will leave that as the
QC shows phred scores >30 across the length of the read so I can let the
Quality algorithms just do their job rather than using trimming.      

I used `multiqc` to generate a summary report of all the many fastqc reports.  

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

4. Re-run fastqc just to check that nothing silly has happend during processing  
7. Stacks *de novo*  
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


9. Reference based stacks  
Align each sample with BWA to the reference genome.  

## Run gstacks to remove PCR duplicates  
See `9.stacks-ref.sh`.  

## Run populations  
As before.  
