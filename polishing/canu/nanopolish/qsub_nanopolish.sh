#!/bin/bash
#$ -N npcanupolish
### -t 1-17
#$ -pe openmp 64
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i

module load enthought_python/7.3.2
module load perl/5.16.2 nanopolish/0.8.1a samtools/1.3
PATH=$PATH:/data/users/solarese/bin/bwa-0.7.16a

INPUT="iso1onpa2.contigs.corrected.fasta"
FASTQ="iso1_onp_a2.fastq"
BAMREADS="reads.sorted.bam"
BAMREADS=$(basename ${BAMREADS} .bam).filtered.bam
THREADS=8
JOBS=8

python nanopolish_makerange.py ${INPUT} | parallel --results nanopolish.results -P ${JOBS} \
    nanopolish variants --consensus polished.{1}.fa -w {1} -r ${FASTQ} -b ${BAMREADS} -g ${INPUT} \
    -t ${THREADS} --min-candidate-frequency 0.1

qsub qsub_npmerge.sh

