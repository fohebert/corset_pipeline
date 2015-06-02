#!/bin/bash
#$ -N Trinity
#$ -M francois-olivier.gagnon-hebert.1@ulaval.ca
#$ -m eas
#$ -pe smp 10
#$ -l h_vmem=80G
#$ -l h_rt=48:00:00
#$ -cwd
#$ -S /bin/bash

time 01_scripts/02.trinity.sh
