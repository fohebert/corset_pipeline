#!/bin/bash
#PBS -A bpv-355-aa
#PBS -N edger
#PBS -o edger.out
#PBS -e edger.err
#PBS -l walltime=08:00:00
#PBS -l nodes=1:ppn=8
#PBS -r n

export PERL5LIB=/home/leluyer/.cpan/CPAN/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/
module load compilers/intel/12.0.4
module load blas-libs/mkl/10.3.4 
module load java/jdk1.6.0
module load misc-libs/pixman/0.26.2
module load misc-libs/cairo/1.12.2
module load apps/r/2.15.1


/rap/bpv-355-aa/trinityrnaseq_r2013_08_14/Analysis/DifferentialExpression/run_DE_analysis.pl \
		--matrix hypothesis1_isoforms.count.matrix \
		--samples_file samples_hyp1.txt \
		--method edgeR \
		--output /home/leluyer/trinity/edgeR_hyp1_dir

# Indicate that EdgeR is done
touch finished.05_edger

