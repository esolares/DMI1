#!/bin/bash
#$ -N pilonqm2x
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,abio

module purge
source ~/.miniconda
#module load jje/pilon
#PATH=$PATH:/data/users/solarese/bin/bowtie2

REF="iso1onpa2_qm_canu_qmdc_new_np_pilon.fasta"
PREFIX="iso1onp_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta)_sorted.bam"

OPTIONS="--vcf --tracks --threads ${NSLOTS}"

#do an if statement
#samtools faidx ${REF}
echo "${QRY}"
echo "${REF}"
pilon ${OPTIONS} --genome ${REF} --frags ${QRY} --output $(basename ${REF} .fasta)_pilon
