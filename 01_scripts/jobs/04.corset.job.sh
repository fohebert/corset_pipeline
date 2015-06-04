#!/bin/bash
#$ -N corset
#$ -M francois-olivier.gagnon-hebert.1@ulaval.ca
#$ -m eas
#$ -pe smp 4
#$ -l h_vmem=20G
#$ -l h_rt=48:00:00
#$ -cwd
#$ -S /bin/bash

time 01_scripts/04.corset.sh
