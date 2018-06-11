#!/bin/bash
#$ -N bt2buildcanu
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="iso1onpa2.contigs.corrected_np_pilon.fasta"
OPTIONS="--threads ${NSLOTS}"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
