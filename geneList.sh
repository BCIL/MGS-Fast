#!/bin/bash
cut -f 3 $1 | sort - | uniq -c - | sort -b -nr -k 1,1 - | grep -v ":" - > $2;sed -i 's/^ *//' $2;cut -f 2 -d " " $2 > $3;grep -Fw -f $3 /home/data/NYU_Metagenomics/IGC_anno > $4;cut -f 8 $4 | grep -v "unknown" - | sort - | uniq -c - | sort -b -nr -k 1,1 - > $5

#1 is input file name, 2 is .gene file, 3 is .list file, 4 _anno.txt file, 5 .kegg
