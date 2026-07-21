#!/bin/bash
BASE=/home/wheeled/projects/202407mcoleman/demultiplex/adtrim.stdlen/final
for sample in $BASE/*.1.fq.gz; 
do 
	mash sketch -r -m 4 -s 1000 ${sample};
done

OUT=/home/wheeled/projects/202407mcoleman/mash
mkdir -p $OUT

mv $BASE/*.msh $OUT/
# pairwise distances
for sample_x in $OUT/*.msh; do  
    for sample_y in $OUT/*.msh; do  
        mash dist ${sample_x} ${sample_y}  
    done  
done>$OUT/All_Distances.txt  
