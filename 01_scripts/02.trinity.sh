#!/bin/bash
# Assembling the trimmed data using Trinity

#GLOBAL VARIABLES
TRIMMED_READS="03_trimmed/sp_assembly"
TRIN_OUT="04_trinity_output"

# Re-group all the reads for a better transcript detection
cat $TRIMMED_READS/*.R1.trim.paired.fastq >$TRIMMED_READS/all-reads.R1.fastq
cat $TRIMMED_READS/*.R2.trim.paired.fastq >$TRIMMED_READS/all-reads.R2.fastq

# Running Trinity to assemble de novo the transcripts
Trinity \
    --bypass_java_version_check \
    --max_memory 70G \
    --CPU 10 \
    --seqType fq \
    --left $TRIMMED_READS/all-reads.R1.fastq \
    --right $TRIMMED_READS/all-reads.R2.fastq \
    --min_contig_length 150 \
    --output $TRIN_OUT

# Getting rid of the numerous output files
mv $TRIN_OUT/Trinity.fasta .
rm -r $TRIN_OUT/* 2> /dev/null
mv Trinity.fasta $TRIN_OUT
