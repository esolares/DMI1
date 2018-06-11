#!/bin/bash
#$ -N nppolishdbg
### -t 1-17
#$ -pe openmp 64
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i

module load enthought_python/7.3.2
module load perl/5.16.2 nanopolish/0.8.1a samtools/1.3
PATH=$PATH:/data/users/solarese/bin/bwa-0.7.16a

INPUT="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new.fasta"
FASTQ="iso1_onp_a2.fastq"
BAMREADS="reads.sorted.bam"
BAMREADS=$(basename ${BAMREADS} .bam).filtered.bam
THREADS=8
JOBS=8

python nanopolish_makerange.py ${INPUT} | parallel --results nanopolish.results -P ${JOBS} \
    nanopolish variants --consensus polished.{1}.fa -w {1} -r ${FASTQ} -b ${BAMREADS} -g ${INPUT} \
    -t ${THREADS} --min-candidate-frequency 0.1

qsub qsub_npmerge.sh

