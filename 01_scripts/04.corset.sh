#!/bin/bash

# GLOBAL VARIABLES
MAPPED='05_map_on_transcriptome'
OUT_DIR='06_corset'
CORSET='/home/fogah/prg/corset-1.04/corset'

# Clusterize contigs according to the Corset method
$CORSET \
    -g NonInfect,NonInfect,NonInfect,NonInfect,NonInfect,NonInfect,NonInfect,Infect,Infect,Infect,Infect,Adult,Adult,Adult \
    -n NI.05-2,NI.E08-2,NI.E12,NI.E13,NI.E14,NI.E22-2,NI.E26,I.E63,I.E67-2,I.E98-W1,I.E98-W2,A.IC03-2,A.IC07,A.IC12 \
    $MAPPED/*.bam

# Moving output files into output directory
rm core
mv clusters.txt $OUT_DIR/
mv counts.txt $OUT_DIR/
