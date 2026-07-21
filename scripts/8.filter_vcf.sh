# Take input vcf file name from user input
myvcf=$1  

# Calculate individual missingness
echo Calculate individual missingness
vcftools --vcf $myvcf --missing-indv --out ${myvcf%%.vcf}  

# Identify samples with over 90% genotypes missing
echo Identify samples with over 90% genotypes missing
tail -n +2 ${myvcf%%.vcf}.imiss | awk '$5>0.9' | cut -f1 > ${myvcf%%.vcf}.rm  

# Remove samples with high missingness and apply standard filters
echo Remove samples with high missingness and apply standard filters
vcftools --vcf $myvcf --remove ${myvcf%%.vcf}.rm --maf 0.05 --max-missing 0.8 --remove-indels --max-alleles 2 --min-alleles 2 --minDP 5 --recode --out ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005  

# Randomly keep only a single SNP from each RAD locus based on distance between SNPs
echo Randomly keep only a single SNP from each RAD locus based on distance between SNPs
vcftools --vcf ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005.recode.vcf --thin 500 --recode --out ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500  

# Recalculate individual missingness
echo Recalculate individual missingness
vcftools --vcf ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500.recode.vcf --missing-indv --out ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500  

# Identify samples with over 50% genotypes missing
echo Identify samples with over 50% genotypes missing
tail -n +2 ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500.imiss | awk '$5>0.5' | cut -f1 >${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005.rm  

# Remove samples with over 50% missingness
echo Remove samples with over 50% missingness
vcftools --vcf ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500.recode.vcf --remove ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005.rm --recode --out ${myvcf%%.vcf}_mim09_biallelic_minDP5_mm08_maf005_thin500_mim05  
