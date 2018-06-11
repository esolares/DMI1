#!/bin/bash
#$ -N npbwadbg
### -t 1-17
#$ -pe openmp 64
#$ -R Y
#$ -q bio,free88i,free72i,bigmemory,pub64,abio,free64

module load enthought_python/7.3.2
module load perl/5.16.2 nanopolish/0.8.1a samtools/1.3
PATH=$PATH:/data/users/solarese/bin/bwa-0.7.16a

INPUT="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new.fasta"
FASTQ="iso1_onp_a2.fastq"
BAMREADS="reads.sorted.bam"
THREADS=64

bwa index ${INPUT}
bwa mem -x ont2d -t ${THREADS} ${INPUT} ../${FASTQ} | samtools sort -o reads.sorted.bam -T reads.tmp
qsub qsub_samtools.sh

