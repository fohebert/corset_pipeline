#!/bin/bash
#$ -N trim
#$ -M francois-olivier.gagnon-hebert.1@ulaval.ca
#$ -m eas
#$ -pe smp 10
#$ -l h_vmem=100G
#$ -l h_rt=10:00:00
#$ -cwd
#$ -S /bin/bash


time 01_scripts/01.Schs.E14.trim.sh
