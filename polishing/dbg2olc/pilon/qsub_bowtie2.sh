#!/bin/bash
#$ -N bt2dbgp
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,pub64,abio

#PATH=$PATH:/data/users/solarese/bin/bowtie2
source ~/.miniconda

QRY1="R1.fastq"
QRY2="R2.fastq"
REF="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new_np.fasta"
PREFIX="iso1onp_illumPE150"
OPTIONS="--threads ${NSLOTS}"

bowtie2 $OPTIONS -x $(basename ${REF} .fasta) -1 ${QRY1} -2 ${QRY2} -S ${PREFIX}_$(basename ${REF} .fasta).sam
qsub qsub_samtools.sh
