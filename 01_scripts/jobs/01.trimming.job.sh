#!/bin/bash
#$ -N trim
#$ -M francois-olivier.gagnon-hebert.1@ulaval.ca
#$ -m eas
#$ -pe smp 10
#$ -l h_vmem=90G
#$ -l h_rt=72:00:00
#$ -cwd
#$ -S /bin/bash

time 01_scripts/01.trimming.sh
