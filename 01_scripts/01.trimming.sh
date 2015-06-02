#!/bin/bash

# GLOBAL VARIABLES
SCRIPTS='01_scripts'
RAW_READS='02_raw_data'

# Looping on all of the read files to create one trimming script/individual
for file in `ls -1 $RAW_READS/*R1*.fastq | sed 's/02_raw_data\///g' | sed 's/\.raw\-reads\.R1\.fastq//g'`; do
    echo export FILENAME=$file | \
    cat - $SCRIPTS/trimming.template.sh >$SCRIPTS/01.$file.trim.sh;
done

# Looping on all of the script files generated above to create job submission scripts
for file in `ls -1 $SCRIPTS/*.trim.sh | sed 's/01_scripts\///g'`; do
    echo time $SCRIPTS/$file | \
    cat $SCRIPTS/jobs/trimming.job.template.sh - >$SCRIPTS/jobs/${file%.sh}.trim.job.sh;
done

# Making sure all the scripts we just created are executable
chmod +x $SCRIPTS/*.sh
chmod +x $SCRIPTS/jobs/*.sh

# Launching the jobs
for file in `ls -1 $SCRIPTS/jobs/*.trim.job.sh`; do qsub $file; done
