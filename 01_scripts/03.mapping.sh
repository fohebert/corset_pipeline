#!/bin/bash

# GLOBAL VARIABLES
REFERENCE='04_trinity_output'
TRIMMED='03_trimmed'
OUT_DIR='05_map_on_transcriptome'
READ_FILES=`ls -1 $TRIMMED/*.R1.trim.paired.fastq | sed 's/\.R1\.trim\.paired\.fastq//g'`

# COPYING THE ASSEMBLY FILE INTO TRIMMED DIRECTORY
cp $REFERENCE/*.fasta $TRIMMED

# PERFORMING THE REFERENCE INDEXING
bowtie-build $TRIMMED/Trinity.fasta Trinity

# PERFORMING THE MAPPING ON THE INDEXED REFERENCE
for F in $READ_FILES; do
    R1=$F.R1.trim.paired.fastq
    R2=$F.R2.trim.paired.fastq
    bowtie --all Trinity -1 $R1 -2 $R2 -p 10 --chunkmbs 2000 --sam $F.sam
    samtools view -bS $F.sam >$F.bam; # Converts SAM --> BAM
done

# CLEANS UP AND TRANSFERS THE OUTPUT FILE INTO THE OUT_DIR
rm $TRIMMED/Trinity.fasta
mv $TRIMMED/*.sam $OUT_DIR
mv $TRIMMED/*.bam $OUT_DIR
mv *.ebwt $OUT_DIR
rm ./*-S_1 ./*-S_2
