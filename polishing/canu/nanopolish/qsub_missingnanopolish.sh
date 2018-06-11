#!/bin/bash
#$ -N missnpcanu
#$ -t 1-28
#$ -pe openmp 8
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,abio

module load nanopolish/0.8.1a samtools/1.3
PATH=$PATH:/data/users/solarese/bin/bwa-0.7.16a
source ~/.miniconda

JOBFILE="missingranges.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)
INPUT="iso1onpa2.contigs.corrected.fasta"
FASTQ="iso1_onp_a2.fastq"

echo "nanopolish variants --consensus polished.${SEED}.fa -w ${SEED} -r ${FASTQ} -b reads.sorted.bam -g ${INPUT} -t 8 --min-candidate-frequency 0.1"
