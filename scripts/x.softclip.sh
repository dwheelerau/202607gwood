samtools view aln/QB48-1B.bam | \
awk '
{
    cigar=$6
    while (match(cigar,/([0-9]+)S/)) {
        print substr(cigar,RSTART,RLENGTH-1)
        cigar=substr(cigar,RSTART+RLENGTH)
    }
}' | sort -n | uniq -c | tail -30
