#!/bin/bash
#$ -N trim
#$ -M francois-olivier.gagnon-hebert.1@ulaval.ca
#$ -m eas
#$ -pe smp 5
#$ -l h_vmem=40G
#$ -l h_rt=10:00:00
#$ -cwd
#$ -S /bin/bash


time 01_scripts/01.Schs.E98-W2.trim.sh
