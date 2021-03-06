#!/bin/bash
#$ -N samtoolsqm2x
### -t 1-17
#$ -pe openmp 48-128
#$ -R Y
#$ -q bigmemory,free88i,free72i,epyc,bio,pub64,abio

module load samtools/1.3

REF="iso1onpa2_qm_canu_qmdc_new_np.fasta"
PREFIX="iso1onp_illumPE150"
QRY="${PREFIX}_$(basename ${REF} .fasta).sam"

OPTIONS="--threads ${NSLOTS}"

samtools view ${OPTIONS} -b ${QRY} --reference ${REF} -o $(basename ${QRY} .sam).bam
samtools sort ${OPTIONS} $(basename ${QRY} .sam).bam -o $(basename ${QRY} .sam)_sorted.bam
samtools index -b $(basename ${QRY} .sam)_sorted.bam $(basename ${QRY} .sam)_sorted.bai
qsub qsub_pilon.sh
