#!/bin/bash
# Trimming reads according to sequencing quality and length thresholds

# GLOBAL VARIABLES
RAW_READS="02_raw_data"
VECTORS="00_archive/univec_trimmomatic.fasta"
TRIMMED_FOLDER="03_trimmed"
TRIMMOMATIC_PROGRAM="/prg/trinityrnaseq/trinityrnaseq_r20140717/trinity-plugins/Trimmomatic-0.32/trimmomatic.jar"

# Filtering and trimming data with trimmomatic

ls -1 $RAW_READS/*.R1.fastq | \
    sed 's/02_raw_data\///g' | \
    sed 's/\.raw-reads\.R1\.fastq//g' | \
    while read i
    do
        echo $i
        java -Xmx80G -jar $TRIMMOMATIC_PROGRAM PE \
            -threads 10 \
            -phred33 \
            $RAW_READS/$i.raw-reads.R1.fastq \
            $RAW_READS/$i.raw-reads.R2.fastq \
            $RAW_READS/$i.R1.trim.paired.fastq \
            $RAW_READS/$i.R1.trim.single.fastq \
            $RAW_READS/$i.R2.trim.paired.fastq \
            $RAW_READS/$i.R2.trim.single.fastq \
            ILLUMINACLIP:$VECTORS:2:30:10 \
            SLIDINGWINDOW:20:2 \
            LEADING:2 \
            TRAILING:2 \
            MINLEN:60
    done

# Places the output from Trimmomatic into the trimmed folder
mkdir $TRIMMED_FOLDER/single
mv $RAW_READS/*single* $TRIMMED_FOLDER/single
mv $RAW_READS/*paired* $TRIMMED_FOLDER
