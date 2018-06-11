#!/bin/bash
#$ -N npmergeqm
### -t 1-17
#$ -pe openmp 1
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,pub64,abio,free64

module load enthought_python/7.3.2
module load perl/5.16.2 nanopolish/0.8.1a samtools/1.3
PATH=$PATH:/data/users/solarese/bin/bwa-0.7.16a

INPUT="iso1onpa2_qm_canu_qmdc_new.fasta"
FASTQ="iso1_onp_a2.fastq"
BAMREADS="reads.sorted.bam"
BAMREADS=$(basename ${BAMREADS} .bam).filtered.bam
THREADS=8
JOBS=8

#nanopolish index --help
nanopolish index -d ./fast5/ ${FASTQ}
