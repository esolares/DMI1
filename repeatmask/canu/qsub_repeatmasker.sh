#!/bin/bash
#$ -N canurm
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q epyc,free88i,bigmemory,free72i,bio,free40i,free32i

#source ~/.mybashrc
module load mchakrab/repeatmasker/4.0.7

OUTDIR=$(pwd)/repeastmask
mkdir -p ${OUTDIR}
MYFASTA=$(ls *.fasta)
RepeatMasker -pa ${NSLOTS} -s -species diptera -a -poly -ace -excln -html -gff -dir ${OUTDIR} ./${MYFASTA}

