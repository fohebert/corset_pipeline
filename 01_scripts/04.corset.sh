#!/bin/bash

# GLOBAL VARIABLES
MAPPED='05_map_on_transcriptome'
OUT_DIR='06_corset'
CORSET='/home/fogah/prg/corset-1.04/corset'

# Clusterize contigs according to the Corset method
$CORSET -g NonInfect,Infect,Adult -n NonInfect-E14,Infect-E98-W2,Adult-IC07 $MAPPED/Schs.E14.bam $MAPPED/Schs.E98-W2.bam $MAPPED/Schs.IC07-2.bam

# Moving output files into output directory
mv clusters.txt $OUT_DIR/
mv counts.txt $OUT_DIR/
