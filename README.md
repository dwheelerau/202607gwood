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
Fastqc does show adaptors need to remove these. Do not apply any
quality trimming as the reads are high quality, let the downstream
algorithms prase quality data in a more sensible way.  

3. Hard trim the R1 using bbduk    
Group final set of reads in `data/adtrim.stdlen/`.  

4. Re-run fastqc just to check that nothing silly has happend during processing  
5. Stacks denovo  

x. Populations

x2. Stacks reference  
