#!/bin/bash
#$ -N bt2builddbgp
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,pub64

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

REF="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new_np_pilon.fasta"
OPTIONS="--threads ${NSLOTS}"

bowtie2-build ${OPTIONS} ${REF} $(basename ${REF} .fasta)
qsub qsub_bowtie2.sh
