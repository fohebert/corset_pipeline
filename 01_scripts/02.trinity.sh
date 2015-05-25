#!/bin/bash

### Global variables (modify as needed)
NORMALIZED_FOLDER="04_normalized"
ASSEMBLY_FOLDER="05_trinity_output"

# Assembly with Trinity 
# min_kmer_cov 2 improves rapidity of assembly but is not recommended
echo 
echo "################################################"
echo "# Writing output to: '$OUTPUT_DIR'"
echo "################################################"
echo 

# Remove output directory
rm -r $OUTPUT_DIR 2> /dev/null

# Launch Trinity
Trinity \
    --seqType fq \
    --JM 160G \
    --CPU 20 \
    --left $NORMALIZED_FOLDER/left_for_trinity.fq.gz \
    --right $NORMALIZED_FOLDER/right_for_trinity.fq.gz \
    --min_contig_length 200 \
    --min_kmer_cov 1 \
    --output $ASSEMBLY_FOLDER
    #--no_run_quantifygraph \
    #--no_run_chrysalis \

# Get scaffolds and cleanup space (optional)
mv $ASSEMBLY_FOLDER/Trinity.fasta .
rm -r $ASSEMBLY_FOLDER/* 2> /dev/null
mv Trinity.fasta $ASSEMBLY_FOLDER

# Indicate that the trinity assembly is done
touch finished.03_trinity

