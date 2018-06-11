#!/bin/bash
#$ -N pilondbgp
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,abio

module purge
source ~/.miniconda
#module load jje/pilon
#PATH=$PATH:/data/users/solarese/bin/bowtie2

REF="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new_np.fasta"
PREFIX="iso1onp_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta)_sorted.bam"

OPTIONS="--vcf --tracks --threads ${NSLOTS}"

#do an if statement
#samtools faidx ${REF}
echo "${QRY}"
echo "${REF}"
pilon ${OPTIONS} --genome ${REF} --frags ${QRY} --output $(basename ${REF} .fasta)_pilon
