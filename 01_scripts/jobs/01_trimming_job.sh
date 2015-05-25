#!/bin/bash
#$ -N trim
#$ -M eric.normandeau@bio.ulaval.ca
#$ -m beas
#$ -pe smp 8
#$ -l h_vmem=100G
#$ -l h_rt=10:00:00
#$ -cwd
#$ -S /bin/bash

time ./01_scripts/01_trimming.sh

