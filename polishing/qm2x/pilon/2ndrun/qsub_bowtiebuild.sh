#!/bin/bash
#$ -N bt2buildqm2x
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="iso1onpa2_qm_canu_qmdc_new_np_pilon.fasta"
OPTIONS="--threads ${NSLOTS}"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
